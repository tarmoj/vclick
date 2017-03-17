/*
	Copyright (C) 2016 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of eClick.

	eClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	eClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with eClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#ifndef OSCHANDLER_H
#define OSCHANDLER_H

#include "qosc/qoscserver.h"
#include <QTimer>

#define OSCPORT 87878 // NB! make sure that this is the same as in main.cpp! TODO: use a setting!

class OscHandler : public QObject
{
	Q_OBJECT
public:
	explicit OscHandler(quint16 port, QObject *parent = 0);
	~OscHandler();
	Q_INVOKABLE QString getLocalAddress();
	Q_INVOKABLE void restart();
	Q_INVOKABLE void setDelay(int delay);

signals:
	void newBeatBar(int bar, int beat);
	void newLed(int led, double duration);
	void newTempo(float tempo);
	void newMessage(QString message, float duration);


public slots:
	void dataIn(QString path, QVariant data);

private:
	QOscServer * m_server;
	int m_bar, m_beat, m_led, m_delay;
	double m_ledDuration;
	float m_tempo, m_messageDuration;
	QString m_message;


private slots:
	void sendBeatBar(); // to use timers to be able to set delays to sync with	other timers
	void sendLed();
	void sendTempo();
	void sendNotification();
};

#endif // OSCHANDLER_H
