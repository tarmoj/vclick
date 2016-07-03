#include <QApplication>
#include <QQmlApplicationEngine>
#include "wsserver.h"
#include "csengine.h"
#include <QQmlContext>
#include <QThread>
#include <QIcon>
#include <QFont>

#ifdef Q_OS_LINUX
	#include "jackreader.h"
#endif

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    app.setFont(QFont("Helvetica")); // otherwise OSX might do strange things

	app.setOrganizationName("eclick"); // for settings
	app.setApplicationName("server");

	app.setWindowIcon(QIcon(":/eclick-server.png"));

	WsServer *wsServer;
	wsServer = new WsServer(6006);  // hiljem muuda, nt 12021
#ifdef Q_OS_LINUX
	JackReader *jackReader = new JackReader();  // started from qml
#endif

	// create csound thread
	QThread * csoundThread = new QThread();
	CsEngine * csound = new CsEngine();
	csound->moveToThread(csoundThread);


	QObject::connect(csoundThread, &QThread::finished, csound, &CsEngine::deleteLater);
	QObject::connect(csoundThread, &QThread::finished, csoundThread, &QThread::deleteLater);
	QObject::connect(&app, SIGNAL(aboutToQuit()), csound, SLOT(stop()) );

	QObject::connect(csound,&CsEngine::newBeatBar, wsServer, &WsServer::handleBeatBar ); // QT5 style of connection
	QObject::connect(csound,&CsEngine::newLed, wsServer, &WsServer::handleLed );
	QObject::connect(csound,&CsEngine::newTempo, wsServer, &WsServer::handleTempo );
	QObject::connect(csound,&CsEngine::newNotification, wsServer, &WsServer::handleNotification );

	csoundThread->start();

	// QML engine and connections

    QQmlApplicationEngine engine;
	//bind object before load
	engine.rootContext()->setContextProperty("wsServer", wsServer); // forward c++ object that can be reached form qml by object name "csound"
	engine.rootContext()->setContextProperty("cs", csound);

#ifdef Q_OS_LINUX
	engine.rootContext()->setContextProperty("jackReader", jackReader);
	QObject::connect(jackReader, SIGNAL(newBeatBar(int,int)), wsServer, SLOT(handleBeatBar(int,int)) );
	QObject::connect(jackReader, SIGNAL(newLed(int,float)), wsServer, SLOT(handleLed(int,float))) ;
#endif

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
