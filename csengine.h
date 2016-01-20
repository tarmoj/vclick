#ifndef CSENGINE_H
#define CSENGINE_H

#include <QObject>
#include "csound.hpp"


class CsEngine : public QObject
{
	Q_OBJECT
public:
	explicit CsEngine(QObject *parent = 0);
	~CsEngine();

signals:

public slots:
	void setChannel(QString channel, MYFLT value);
	void play();
	void stop();
	void scoreEvent(QString event);

private:
	Csound * cs;
	QString csd; // resolve later
	bool stopNow;
};

#endif // CSENGINE_H
