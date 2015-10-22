#include "jackreader.h"
#include <QDebug>


JackReader::JackReader()
{
	mStop = false;
}

JackReader::~JackReader()
{

}

void JackReader::run() {


	int oldbar = 0, oldbeat = 0;
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
	 //is it necessary to put it rolling?
	if (transport_state != JackTransportRolling)
		jack_transport_start(client);

	while (!mStop) {
		transport_state = jack_transport_query (client, &current);
		//frame_time = jack_frame_time (client);

		if (current.valid & JackPositionBBT &&
				(current.beat!=oldbeat || current.bar!=oldbar)) {
			qDebug()<<"BBT: "<<current.bar << " | " << current.beat;

			oldbeat = current.beat;
			oldbar = current.bar;
			emit newBeatBar(current.bar, current.beat);
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

