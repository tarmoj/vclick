
/*
	Copyright (C) 2016 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of eyeClick.

	eyeClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	eyeClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with eyeClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#ifndef JACKREADER_H
#define JACKREADER_H

#include <QThread>

#include <jack/jack.h>
#include <jack/transport.h>


class JackReader : public QThread
{
	Q_OBJECT
public:
	explicit JackReader();
	~JackReader();
	void run();
	Q_INVOKABLE void stop();


private:
	bool mStop;
	bool startFromZero; // a hack to make 60-beat measures and show as timecode...



signals:
	void newBeatBar(int bar, int beat);
	void newLed(int led, float duration);
	void newTempo(double tempo);
public slots:
	void setZeroHack(bool state) {startFromZero= state;}
};

#endif // JACKREADER_H
