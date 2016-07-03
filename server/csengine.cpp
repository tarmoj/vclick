#include "csengine.h"
#include <QDebug>
#include <QCoreApplication>
#include <QFile>
#include <QDir>
#include <QTemporaryFile>

CsEngine::CsEngine(QObject *parent) : QObject(parent)
{
	stopNow = false;
	//temp:
    m_orc=":/csound/metro_simple.orc"; //"/home/tarmo/tarmo/csound/metronome/metro_simple.orc"; // TODO: to settings
    //m_sco= "/home/tarmo/tarmo/csound/metronome/test.sco"; // probably dont need.
    //m_options = "-odac -+rtaudio=null"; // into Settings;
	QObject::connect(this, SIGNAL(startPlaying(QString, int)), this, SLOT(play(QString, int)));
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
				int barno = fields[7].toInt(); // NB! does not work, if 'i2'
				if (barno==startBar) {
					qDebug()<<"Found bar "<<barno;
					startTime = fields[2].toFloat();
					qDebug()<<"Starts at: " << startTime;

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
	cs = new Csound();
	QString message;
	cs->CreateMessageBuffer(1); // also to stdout for debugging

	cs->SetOption("-odac"); // TODO: miks ei saa saata koos orc ja sco reaga?
    cs->SetOption("-+rtaudio=null");
    //QString tempOrcName = QDir::tempPath() + "/temp.orc";
    QTemporaryFile * tempOrcFile;// now a file with name server.XXX is created... not deleted.... (QDir::tempPath()+"/XXXXXX.orc");
    tempOrcFile = QTemporaryFile::createNativeFile(":/csound/metro_simple.orc");
    //bool copyresult=QFile::copy(m_orc,tempOrcName); // works! TODO: korralik ja loogiline kood! m_orc ilmselt mittevajalik...
    //int result = cs->Compile(tempOrcName.toLocal8Bit().data(), scoFile.toLocal8Bit().data() );

	int result = cs->Compile(tempOrcFile->fileName().toLocal8Bit().data(), scoFile.toLocal8Bit().data() );

	while (cs->GetMessageCnt()>0) { // HOW to get error message here?
		message += QString(cs->GetFirstMessage()) + "\n";
		//qDebug()<<"Csound MESSAGE: " << message;
		cs->PopFirstMessage();
	}
	if (!message.isEmpty()) {
		emit csoundMessage(message.trimmed());
	}

    if (!result ) {

		MYFLT bar, beat, tempo, flagUp; // flagUp - for how many seconds show a new notification
		MYFLT oldTempo=0, oldBar=-1, oldBeat=-1;
		QStringList leds = QStringList() <<"red"<<"green"<<"blue";
		while (cs->PerformKsmps()==0 && !stopNow) {
			for (int i=0;i<3;i++) {
				MYFLT duration =  getChannel(leds[i]);
				if (duration>0) {
					emit newLed(i,duration);
					qDebug()<<leds[i].toUpper()<<": " <<duration;
					setChannel(leds[i],0); // set to 0 in Csound
				}
			}

			beat = getChannel("beat");
			bar = getChannel("bar");
			if (beat!=oldBeat || bar!=oldBar) {
                emit newBeatBar( int(bar), round(beat)); // round since sometimes given as 5.2999999
                qDebug()<<"BAR: "<<int(bar)<< "BEAT: "<<round(beat);
				oldBeat = beat; oldBar = bar;
				// check for tempo changes:
				tempo = getChannel("tempo");
				if (tempo!=oldTempo) {
					emit newTempo(tempo);
					qDebug()<<"TEMPO: "<<tempo;
					oldTempo = tempo;
				}
			}

			flagUp = getChannel("new_notification"); // duration > 0 if new message in the string channel
			if (flagUp>0) {
				QString notification = getStringChannel("notification");
				qDebug()<<"NOTIFICATION: " << notification << "for (seconds:) " << flagUp;
				emit newNotification(notification, flagUp);
				setChannel("new_notification",0);
			}

			if (cs->GetMessageCnt()>0) {
				message = QString(cs->GetFirstMessage());
				//qDebug()<<"Csound MESSAGE: " << message;
				emit csoundMessage(message.trimmed());
				cs->PopFirstMessage();
			}

			QCoreApplication::processEvents(); // probably bad solution but works. otherwise other slots will never be calles
		}
		qDebug()<<"Stopping csound";
		cs->Stop();
        tempOrcFile->remove(); // for any case
	} else {
		qDebug()<<"Could not compile and strart with score file: "<<scoFile;
	}
	cs->DestroyMessageBuffer();
	delete cs;
	stopNow = false;

}

void CsEngine::stop() {
	stopNow = true;
}

void CsEngine::setChannel(QString channel, double value) {
	//qDebug()<<"channel: "<<channel << " value: "<<value;
	cs->SetChannel(channel.toLocal8Bit(),value);
}


double CsEngine::getChannel(QString channel)
{
	MYFLT value = cs->GetChannel(channel.toLocal8Bit());
//	if (value>0)
//		qDebug()<<"channel: "<<channel << " value: "<<value;
	return value;
}

QString CsEngine::getStringChannel(QString channel)
{

	char string[1024]; // to assume the message is not longer...
	cs->GetStringChannel(channel.toLocal8Bit(),string);
	return QString(string);

}

void CsEngine::scoreEvent(QString event)
{
	cs->InputMessage(event.toLocal8Bit());
}
