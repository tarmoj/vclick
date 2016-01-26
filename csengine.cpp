#include "csengine.h"
#include <QDebug>
#include <QCoreApplication>


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
	m_sco = scoFile;
	emit startPlaying(scoFile, startBar);
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
					emit newTempo(QString::number(tempo,'g',3));
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
