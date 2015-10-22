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



signals:
	void newBeatBar(int bar, int beat);
	void newLed(int led, float duration);
public slots:
};

#endif // JACKREADER_H
