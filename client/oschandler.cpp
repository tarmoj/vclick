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
#include "oschandler.h"
#include <QNetworkInterface>
#include <QThread>

OscHandler::OscHandler(quint16 port, QObject *parent) : QObject(parent)
{
	m_port = port;
	m_server = new QOscServer(m_port, parent); //TODO: osc port now hardcoded, put into config
    m_delay = 0;
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
				break; // get the first address (avoid bridges etc)

		}

	}
	return address;
}

void OscHandler::restart()
{
	qDebug()<<"Stopping";
	delete m_server;
    QThread::msleep(500);
	m_server = new QOscServer(m_port, nullptr);
    qDebug()<<"Created again";
	connect(m_server, SIGNAL(dataIn(QString,QVariant)),this, SLOT(dataIn(QString,QVariant)));
    m_server->

}

void OscHandler::setDelay(int delay)
{
	m_delay = delay;
	qDebug()<<"Setting delay to: "<<delay<<" ms";
}

void OscHandler::setPort(quint16 port)
{
	m_port = port;
	restart();
}

// TODO  methods start/stop listening-  perhaps disconnect/connect SIGNAL(dataIn() )

void OscHandler::dataIn(QString path, QVariant data)
{
	//int type = static_cast<int>(data.type());
	//qDebug() << "OscHandler::dataIn " << path << " " << data<<type;
	QList <QVariant> args = data.toList();
	if (path.startsWith("/metronome/beatbar")) {
		if (args.length()>=2) {
			m_bar = args[0].toInt();
			m_beat = args[1].toInt();
			QTimer::singleShot(m_delay, this, SLOT(sendBeatBar()));
		}
	}

	if (path.startsWith("/metronome/led")) {
		if (args.length()>=2) {
			m_led = args[0].toInt();
			m_ledDuration = static_cast<double>(args[1].toFloat());
			//qDebug()<<"LED"<<led<<duration;
			QTimer::singleShot(m_delay, this, SLOT(sendLed()));
		}
	}

	if (path.startsWith("/metronome/tempo")) {
		if (data.type()==QMetaType::Float){
			m_tempo = data.toFloat();
			//qDebug()<<"TEMPO"<<tempo;
			QTimer::singleShot(m_delay, this, SLOT(sendTempo()));
		}
	}

	if (path.startsWith("/metronome/notification")) {
		if (args.length()>=2) {
			m_message = args[0].toString();
			m_messageDuration = args[1].toFloat();
			QTimer::singleShot(m_delay, this, SLOT(sendNotification()));
		} else if (data.type()==QMetaType::QString){
			m_message = data.toString();
			m_messageDuration = 4.0;
			QTimer::singleShot(m_delay, this, SLOT(sendNotification()));
		}
	}


}

void OscHandler::sendBeatBar()
{
	emit newBeatBar(m_bar, m_beat);
}

void OscHandler::sendLed()
{
	emit newLed(m_led, m_ledDuration);
}

void OscHandler::sendTempo()
{
	emit newTempo(m_tempo);
}

void OscHandler::sendNotification()
{
	emit newMessage(m_message, m_messageDuration);
}

