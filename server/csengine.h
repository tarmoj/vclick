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

private:
	Csound * cs;
	QString m_sco, m_orc, m_options; // resolve later
	bool stopNow;
};

#endif // CSENGINE_H
