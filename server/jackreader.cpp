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
#include "jackreader.h"
#include <QDebug>


JackReader::JackReader()
{
	mStop = false;
	startFromZero = false; // a hack to make 60-beat measures and show as timecode... The session must be in tempo 60, 60/4
}

JackReader::~JackReader()
{

}

void JackReader::run() {


	int oldbar = 0, oldbeat = 0;
	double oldTempo=0;
	jack_client_t *client;

	if ((client = jack_client_open ("readTime", JackNullOption, NULL)) == 0) {
		qDebug()<<"Jack server not running?";
		exit(1);
	}

	if (jack_activate (client)) {
		qDebug()<<"Cannot activate client";
		exit(1);
	}

	jack_transport_state_t transport_state;
	jack_position_t current;
	transport_state = jack_transport_query (client, &current);

	if (transport_state != JackTransportRolling)
		jack_transport_start(client); // must be rolling

	while (!mStop) {
		transport_state = jack_transport_query (client, &current);
		//long  frame_time = jack_frame_time (client);

		if (current.valid & JackPositionBBT &&
				(current.beat!=oldbeat || current.bar!=oldbar)) {
			qDebug()<<"BBT: "<<current.bar << " | " << current.beat;
			// TODO: tempo current.beats_per_minute
			if (current.beats_per_minute != oldTempo) {
				emit newTempo(current.beats_per_minute);
				qDebug()<<"New tempo: "<<current.beats_per_minute;
				oldTempo = current.beats_per_minute;
			}


			oldbeat = current.beat;
			oldbar = current.bar;
			//NB! a hack

			if (startFromZero) {
				emit newBeatBar(current.bar-1, current.beat-1);
			} else {
				emit newBeatBar(current.bar, current.beat);
			}


			// löögi jaoks vt QElapsedTimer
			int led = (current.beat==1) ? 0 : 1; // 0 - for red, 1 for green, 2 for blue
			float duration = 60.0/current.beats_per_minute;
			emit newLed(led, duration);
		}

		msleep(20);


	}
	// delete what necessary

	jack_transport_stop(client);
	jack_client_close (client);

	this->exit(0);
}

void JackReader::stop()
{
	mStop=true;
}

