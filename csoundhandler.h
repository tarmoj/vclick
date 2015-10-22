#ifndef CSOUNDHANDLER_H
#define CSOUNDHANDLER_H

#include <QObject>
#include <csound/csound.hpp>
//#include <csound/csPerfThread.hpp>

class CsoundHandler : public QObject
{
	Q_OBJECT
public:
	explicit CsoundHandler(QObject *parent = 0);
	~CsoundHandler();

signals:
	double newChannelValue(QString channel, double value);

public slots:

	void start(QString scoFile) {start(scoFile, 1); }
	void start(QString scoFileName, int fromBar);
	void stop();

private:
	//QString scoreFile;


};

#endif // CSOUNDHANDLER_H
