#ifndef OSCHANDLER_H
#define OSCHANDLER_H

#include "src/qoscserver.h"


class OscHandler : public QObject
{
	Q_OBJECT
public:
	explicit OscHandler(quint16 port, QObject *parent = 0);
	~OscHandler();
	Q_INVOKABLE QString getLocalAddress();

signals:
	void newBeatBar(int bar, int beat);
	void newLed(int led, double duration);
	void newTempo(float tempo);
	void newMessage(QString message, float duration);


public slots:
	void dataIn(QString path, QVariant data);

private:
	QOscServer * m_server;

};

#endif // OSCHANDLER_H
