#include "csengine.h"
#include <QDebug>
#include <QCoreApplication>
#include <QFile>


CsEngine::CsEngine(QObject *parent) : QObject(parent)
{
	stopNow = false;
	//temp:
	m_orc="/home/tarmo/tarmo/csound/metronome/metro_simple.orc"; // TODO: to settings
	m_sco= "/home/tarmo/tarmo/csound/metronome/test.sco"; // probably dont need.
	m_options = "-odac -+rtaudio=null"; // into Settings;
	QObject::connect(this, SIGNAL(startPlaying(QString, int)), this, SLOT(play(QString, int)));
}

CsEngine::~CsEngine()
{
	cs->Stop();
	delete cs;  // this is probably not necessary
}


//void CsEngine::setOrcSco(QString orc, QString sco)
//{
//	m_orc=orc; m_sco=sco;
//}


void CsEngine::start(QString scoFile, int startBar) // TODO - ühenda kohe QML signal play külge.
{
	// check for starting bar number and construct a temporary score with necessary changes:
	// load scoreFile
	QFile scoreFile(scoFile.remove("file:/")); // otherwise does not open...

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
		QFile tempFile("temp.sco");
		if (tempFile.open(QFile::WriteOnly  |QFile::Text) ) {
			tempFile.write(contents.toLocal8Bit().data());
			qDebug()<<"TEMP file: "<<tempFile.fileName();
			tempFile.close();
		}

		emit startPlaying("temp.sco", startBar); // TODO: name of temporary file!
	}



}

void CsEngine::play(QString scoFile, int startBar) {
	cs = new Csound();
	cs->SetOption("-odac"); // TODO: miks ei saa saata koos orc ja sco reaga?
	cs->SetOption("-+rtaudio=null");
	int result = cs->Compile(m_orc.toLocal8Bit().data(), scoFile.toLocal8Bit().data() );

	if (!result ) {

		MYFLT bar, beat, red, green, blue, tempo, flagUp; // flagUp - for how many seconds show a new notification
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
				emit newBeatBar((MYFLT) int(bar), beat);
				qDebug()<<"BAR: "<<bar<< "BEAT: "<<beat;
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

			// NOTIFICATION: TODO: string channel


			QCoreApplication::processEvents(); // probably bad solution but works. otherwise other slots will never be calles
		}
		qDebug()<<"Stopping csound";
		cs->Stop();
	} else {
		qDebug()<<"Could not compile and strart with score file: "<<scoFile;
	}

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
