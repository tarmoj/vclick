#include "oschandler.h"
#include <QNetworkInterface>

OscHandler::OscHandler(quint16 port, QObject *parent) : QObject(parent)
{
	m_server = new QOscServer(port, parent); //TODO: osc port now hardcoded, put into config

	connect(m_server, SIGNAL(dataIn(QString,QVariant)),this, SLOT(dataIn(QString,QVariant)));
}

OscHandler::~OscHandler()
{
	// how to stop m_server? delete_later?
}

QString OscHandler::getLocalAddress()
{
	QString address = QString();
	QList <QHostAddress> localAddresses = QNetworkInterface::allAddresses();
	for(int i = 0; i < localAddresses.count(); i++) {

		if(!localAddresses[i].isLoopback())
			if (localAddresses[i].protocol() == QAbstractSocket::IPv4Protocol ) {
				address = localAddresses[i].toString();
				qDebug() << "YOUR IP: " << address;

		}

	}
	return address;
}

void OscHandler::dataIn(QString path, QVariant data)
{
	int type = data.type();
	qDebug() << "OscHandler::dataIn " << path << " " << data<<type;
	QList <QVariant> args = data.toList();
	if (path.startsWith("/metronome/beatbar")) {
		if (args.length()>=2) {
			int bar = args[0].toInt();
			int beat = args[1].toInt();
			//qDebug()<<"BEATBAR"<<bar<<beat;
			emit newBeatBar(bar, beat);
		}
	}

	if (path.startsWith("/metronome/led")) {
		if (args.length()>=2) {
			int led = args[0].toInt();
			float duration = args[1].toFloat();
			//qDebug()<<"LED"<<led<<duration;
			emit newLed(led, duration);
		}
	}

	if (path.startsWith("/metronome/tempo")) {
		if (data.type()==QMetaType::Float){
			float tempo = data.toFloat();
			//qDebug()<<"TEMPO"<<tempo;
			emit newTempo(tempo);
		}
	}

	if (path.startsWith("/metronome/notification")) {
		if (data.type()==QMetaType::QString){
			QString message = data.toString();
			//qDebug()<<"MESSAGE: "<<message;
			emit newMessage(message);
		}
	}


}

