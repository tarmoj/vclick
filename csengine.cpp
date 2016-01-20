#include "csengine.h"
#include <QDebug>
#include <QCoreApplication>


CsEngine::CsEngine(QObject *parent) : QObject(parent)
{
	csd = "../breathing-game.csd";
	stopNow = false;
}

CsEngine::~CsEngine()
{
	stop(); // this is mess
}


void CsEngine::play() {
	cs = new Csound();
	cs->Compile(csd.toLocal8Bit().data()); // ERROR HANDLING!
	while (cs->PerformKsmps()==0 && !stopNow) {
		QCoreApplication::processEvents(); // probably bad solution but works. otherwise other slots will never be calles
	}
	qDebug()<<"Stopping csound";
	cs->Stop();
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

void CsEngine::scoreEvent(QString event)
{
	cs->InputMessage(event.toLocal8Bit());
}
