#include <QApplication>
#include <QQmlApplicationEngine>
#include "wsserver.h"
#include "jackreader.h"
#include "csoundhandler.h"
#include "csengine.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	WsServer *wsServer;
	wsServer = new WsServer(6006);  // hiljem muuda, nt 12021

	JackReader *jackReader = new JackReader();  // started from qml
	//jackReader->start();

	CsoundHandler cs;
	//cs.start("/home/tarmo/tarmo/csound/metronome/scott/scott.sco",20);

	// Csound engige --------------
	// move csound into another thread

	QThread * csoundThread = new QThread();
	CsEngine * csound = new CsEngine();
	csound->moveToThread(csoundThread);


	QObject::connect(csoundThread, &QThread::finished, csound, &CsEngine::deleteLater);
	QObject::connect(csoundThread, &QThread::finished, csoundThread, &QThread::deleteLater);
	QObject::connect(&app, SIGNAL(aboutToQuit()), csound, SLOT(stop()) );

	// kuskile funtsioonid startCsound, stopCsoundm thread private
	// stopCsound -> connecct widget destoyed ja kuskil cs->stop(), csoundThread.quit(), csoundThread.wait()
	//connect(&app, &Q::destroyed, csound, &CsEngine::stop); // <-mõtle seda... võibolla engine'iga
	//QObject::connect(csoundThread, &QThread::started, csound, &CsEngine::play);

	//connect(this, &BreathWindow::newChannelValue, cs, &CsEngine::setChannel );
	//connect(this, &BreathWindow::newScoreEvent, cs, &CsEngine::scoreEvent );

	//connect(wsServer, &WsServer::newChannelValue, cs, &CsEngine::setChannel );
	//connect(wsServer, &WsServer::newScoreEvent, cs, &CsEngine::scoreEvent );


	csoundThread->start();

	//-----


    QQmlApplicationEngine engine;
	//bind object before load
	engine.rootContext()->setContextProperty("wsServer", wsServer); // forward c++ object that can be reached form qml by object name "csound"
	engine.rootContext()->setContextProperty("jackReader", jackReader);
	//engine.rootContext()->setContextProperty("cs", &cs);
	engine.rootContext()->setContextProperty("cs", csound);
	QObject::connect(jackReader, SIGNAL(newBeatBar(int,int)), wsServer, SLOT(handleBeatBar(int,int)) );

	QObject::connect(jackReader, SIGNAL(newLed(int,float)), wsServer, SLOT(handleLed(int,float))) ;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
