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
#ifndef CSENGINE_H
#define CSENGINE_H

#include <QObject>
#include <QUrl>
#include "csound.hpp"


class CsEngine : public QObject
{
	Q_OBJECT
public:
	explicit CsEngine(QObject *parent = 0);
	~CsEngine();

	//Q_INVOKABLE void setOrcSco(QString orc, QString sco);
	Q_INVOKABLE MYFLT getChannel(QString channel);
	Q_INVOKABLE QString getStringChannel(QString channel);

signals:
	void startPlaying(QString scoFile, int startBar);
	void newBeatBar(int bar, int beat);
	void newLed(int ledNumber, float duration);
	void newNotification(QString message, float duration);
	void newTempo(double tempo); // TODO: change to double/float
	void csoundMessage(QString message);

public slots:
	void setChannel(QString channel, MYFLT value);

	void start(QUrl scoFile, int startBar);
	void play(QString scoFile, int startBar);
	void stop();
	void scoreEvent(QString event);
	void setSFDIR(QUrl dir);

private:
	Csound * cs;
	QString m_sco, m_orc, m_options; // resolve later
	bool stopNow, isRunning;
	QString SFDIR;
};

#endif // CSENGINE_H
