/*
	Copyright (C) 2016 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of vClick.

	vClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	vClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with vClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#include "csengine.h"
#include <QDebug>
#include <QCoreApplication>
#include <QFile>
#include <QDir>
#include <QTemporaryFile>
#include <QSettings>
#include <QThread>

CsEngine::CsEngine(QObject *parent) : QObject(parent)
{
	stopNow = false;
	isRunning = false;
	cs = nullptr;
	m_orc=":/csound/metro_simple.orc";
	QObject::connect(this, SIGNAL(startPlaying(QString, int)), this, SLOT(play(QString, int)));
	oscPort = 58787;
}

CsEngine::~CsEngine()
{
    //cs->Stop();
    //delete cs;  // this is probably not necessary
}


//void CsEngine::setOrcSco(QString orc, QString sco)
//{
//	m_orc=orc; m_sco=sco;
//}


void CsEngine::start(QUrl scoFile, int startBar) // TODO - ühenda kohe QML signal play külge.
{
	if (isRunning) {
		stop(); // or is it possible to stop, wait while done and then continue?
		qDebug()<<"vClick is running. Stopping now. Please press Start again!";
        QThread::sleep(1);
		//return;
	}
	// check for starting bar number and construct a temporary score with necessary changes:
	// load scoreFile
	//QUrl scoreUrl(scoFile); //QUrl::fromLocalFile(scoFile); // to get rid of file:/// e
    QString testname = (scoFile.toString().startsWith("file:") ) ? scoFile.toLocalFile() : scoFile.path(); //":/csound/test.sco"; //scoreUrl.toLocalFile();
    QFile scoreFile(testname);

	if (scoreFile.open(QFile::ReadOnly  |QFile::Text)) {
		QString contents = QString(scoreFile.readAll());
		QStringList lines = contents.split("\n");
		QStringList tempoLines;
		float startTime = 0;
		foreach (QString line, lines) {
			line = line.simplified();
			if (line.startsWith("i 1 ") || line.startsWith("i1 ") ) {
				qDebug()<<"tempo line: "<<line;
				tempoLines.append(line);
			}
			if (line.startsWith("i 2") || line.startsWith("i2") ) { // TODO: OR starts with i \"bar\"
				QStringList fields = line.split(" ");
                if (fields.count()>=7) {
                    int barno = fields[7].toInt(); // NB! does not work, if 'i2'
                    if (barno==startBar) {
                        qDebug()<<"Found bar "<<barno;
                        startTime = fields[2].toFloat();
                        qDebug()<<"Starts at: " << startTime;

                    }
                } else {
                    qDebug()<<"There must be at least 7 fields in the scoreline: "<<line;
                }
			}

		}

		if (startBar>1) {
			QString tempo = "#TEMPO1#";
			QString replaceString = "a 0 0 "+ QString::number(startTime - 0.01) + "\n";

			// find what was the last temo setting (i 1 statement) before startTime and reinsert it
			for (int i=tempoLines.length()-1; i>=0;i--) { // from end towards beginning
				QStringList fields = tempoLines[i].split(" ");
				if (fields[2].toFloat() <= startTime) {
					fields[2] = QString::number(startTime); // replace the time that is jumped over with the time where the bar starts
					tempo = fields[4] ;
					QString newTempoLine = fields.join(" ") + "\n\n";
					replaceString += newTempoLine;
					break; // no more searching needed
				}
			}
			qDebug()<<"replaceString: "<<replaceString;
			contents.replace(";ADVANCE",replaceString);
			contents.replace( "#define REPTEMPO #$TEMPO1#", "#define REPTEMPO #" + tempo + "#"); // tempo of count-down
			contents.replace( "#define REPTEMPO #60#", "#define REPTEMPO #" + tempo + "#"); // another version, since sometimes it is not #$TEMPO1# but #60# (Murail Winter Fragments)
		}

		//QTemporaryFile tempFile(QDir::tempPath()+"/XXXXXX.sco"); // TODO: use temporary file! - see how not to close it too soon
        QString tempName = QDir::tempPath() + "/temp.sco";
        QFile tempFile(tempName);
		if (tempFile.open(QFile::WriteOnly  |QFile::Text) ) {
			tempFile.write(contents.toLocal8Bit().data());
			qDebug()<<"TEMP file: "<<tempFile.fileName();
			tempFile.close();
		}

        emit startPlaying(tempName, startBar); // TODO: name of temporary file!
	}
    else {
        qDebug()<<"Could not open file "<<scoFile;
    }



}

void CsEngine::play(QString scoFile, int startBar) {
	cs = new Csound(); // must check here, if it is already running. stop if is running. Tink, see CsoundQT and test....
	QString message;
    cs->CreateMessageBuffer(0); // also to stdout for debugging
	//TODO: options from settings
	QSettings settings("vclick","server");
	QString csoundOptions= settings.value("csoundOptions").toString().simplified() ;
	if (csoundOptions.isEmpty()) {
		csoundOptions = "-odac -+rtaudio=null -d";
	}

	foreach (QString option, csoundOptions.split(" ")) {
		qDebug()<<"Setting Csound option: " << option;
		cs->SetOption(option.toLocal8Bit().data());
	}

	// look for SFDIR set by UI

	QString sfdir = settings.value("sfdir").toString(); // proabably converting to String and stripping file:/// makes much more sense...


	if (!csoundOptions.contains("SFIDR") && !sfdir.isEmpty() && !csoundOptions.contains("null")) { // set SFDIR chosen in UI
		//sfdir = (sfdir.toString().startsWith("file:") ) ? sfdir.toLocalFile() : sfdir.path();

        // for windows remove the first /
#ifdef Q_OS_WIN
        sfdir=sfdir.replace("file:///", ""); // remove also the first /
#else
        sfdir=sfdir.replace("file:///", "/");
#endif
		qDebug()<<"Set SFDIR to: " << sfdir;
		QString option = "--env:SFDIR="+ sfdir; // TODO: does it work if path has spaces??
		cs->SetOption(option.toLocal8Bit().data());
	}

	QTemporaryFile * tempOrcFile;// now a file with name server.XXX is created... not deleted.... (QDir::tempPath()+"/XXXXXX.orc");
	tempOrcFile = QTemporaryFile::createNativeFile(":/csound/metro_sendosc.orc"); // WAS: metro_simple.orc


	int result = cs->Compile(tempOrcFile->fileName().toLocal8Bit().data(), scoFile.toLocal8Bit().data() );
	if (!result && !oscLineToCompile.isEmpty()) {
		cs->CompileOrc(oscLineToCompile.toLocal8Bit());
	}
	while (cs->GetMessageCnt()>0) { // HOW to get error message here?
        message += QString(cs->GetFirstMessage()).simplified() + "\n";
		//qDebug()<<"Csound MESSAGE: " << message;
		cs->PopFirstMessage();
	}
	if (!message.isEmpty()) {
		emit csoundMessage(message.trimmed());
	}

    if (!result ) {
		isRunning = true;
		MYFLT bar, beat, tempo, flagUp; // flagUp - for how many seconds show a new notification
		MYFLT oldTempo=0, oldBar=-1, oldBeat=-1;
		//QStringList leds = QStringList() <<"red"<<"green"<<"blue";
		while (cs->PerformKsmps()==0 && !stopNow) {
			/* don't care abou leds any more, csound send OSC messages
			for (int i=0;i<3;i++) {
				MYFLT duration =  getChannel(leds[i]);
				if (duration>0) {
					emit newLed(i,duration);
					qDebug()<<leds[i].toUpper()<<": " <<duration;
					setChannel(leds[i],0); // set to 0 in Csound
				}
			}
			*/
			beat = getChannel("beat");
			bar = getChannel("bar");
			if (beat!=oldBeat || bar!=oldBar) {
                emit newBeatBar( int(bar), round(beat)); // round since sometimes given as 5.2999999
				//qDebug()<<"BAR: "<<int(bar)<< "BEAT: "<<round(beat);
				oldBeat = beat; oldBar = bar;
				// check for tempo changes:
				tempo = getChannel("tempo");
				if (tempo!=oldTempo) {
					emit newTempo(tempo);
					qDebug()<<"TEMPO: "<<tempo;
					oldTempo = tempo;
				}
			}
			/* don't care about notifications any more
			flagUp = getChannel("new_notification"); // duration > 0 if new message in the string channel
			if (flagUp>0) {
				QString notification = getStringChannel("notification");
				qDebug()<<"NOTIFICATION: " << notification << "for (seconds:) " << flagUp;
				emit newNotification(notification, flagUp);
				setChannel("new_notification",0);
			}
			*/
			if (cs->GetMessageCnt()>0) {
                message = QString(cs->GetFirstMessage());
                //qDebug()<<"Csound MESSAGE: " << message;
				emit csoundMessage(message.trimmed());
				cs->PopFirstMessage();
			}

			QCoreApplication::processEvents(); // probably bad solution but works. otherwise other slots will never be called
		}
		qDebug()<<"Stopping csound";
		cs->Stop();
        tempOrcFile->remove(); // for any case
	} else {
		qDebug()<<"Could not compile and strart with score file: "<<scoFile;
	}
	cs->DestroyMessageBuffer();
	delete cs;
	cs = nullptr;
	stopNow = false;
	isRunning = false;
	tempOrcFile->deleteLater();
}

void CsEngine::stop() {
	if (isRunning)
		stopNow = true;
	else
		qDebug()<<"vClick server was not running!";
}

void CsEngine::setChannel(QString channel, double value) {
	//qDebug()<<"channel: "<<channel << " value: "<<value;
	if (cs) // check if created
		cs->SetChannel(channel.toLocal8Bit(),value);
}


double CsEngine::getChannel(QString channel)
{
	if (cs) {
		MYFLT value = cs->GetChannel(channel.toLocal8Bit());
		//	if (value>0)
		//		qDebug()<<"channel: "<<channel << " value: "<<value;
		return value;
	} else
		return -1;
}

QString CsEngine::getStringChannel(QString channel)
{
	if (cs) {
	char string[2048]; // to assume the message is not longer...
	cs->GetStringChannel(channel.toLocal8Bit(),string);
	return QString(string);
	} else
		return QString();

}

void CsEngine::scoreEvent(QString event)
{
	if (cs)
		cs->InputMessage(event.toLocal8Bit());
}

void CsEngine::setSFDIR(QUrl dir)
{
	SFDIR = (dir.toString().startsWith("file:") ) ? dir.toLocalFile() : dir.path();
	qDebug()<<"Set SFDIR to: " << SFDIR;
}

void CsEngine::compileOrc(QString code)
{
	if (cs)
		cs->CompileOrc(code.toLocal8Bit());
}

void CsEngine::setOscAddresses(QString addresses)
{
	oscLineToCompile = "gSclients fillarray ";
	int clientsCount = 0;

	foreach (QString address, addresses.split(",")) {
		address = address.simplified();
		address = (address=="localhost") ? "127.0.0.1" : address; // does not like "localhost" as string
		if (!address.isEmpty()) { // for any case
			// create string about addresses for Csound and compileit as orchestra
			oscLineToCompile += "\"" + address + "\",";
			clientsCount++;

		}
	}
	if (clientsCount) {
		oscLineToCompile.chop(1) ; //remove last ","
		oscLineToCompile += "\ngiClientsCount init " + QString::number(clientsCount);
	} else {
		oscLineToCompile = "giClientsCount init 0";
	}
	oscLineToCompile += QString("\ngiOscPort init %1\n").arg(oscPort);
	qDebug()<<"Line to compile: "<<oscLineToCompile;
	if (cs) {
		cs->CompileOrc(oscLineToCompile.toLocal8Bit());
	}

}

void CsEngine::setOscPort(int port)
{
	qDebug() << "Set oscPort in Csound to: " << port;
	oscPort = port;
}
