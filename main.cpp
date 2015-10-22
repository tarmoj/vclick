#include <QApplication>
#include <QQmlApplicationEngine>
#include "wsserver.h"
#include "jackreader.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	WsServer *wsServer;
	wsServer = new WsServer(6006);  // hiljem muuda, nt 12021

	JackReader *jackReader = new JackReader();  // started from qml
	//jackReader->start();

    QQmlApplicationEngine engine;
	//bind object before load
	engine.rootContext()->setContextProperty("wsServer", wsServer); // forward c++ object that can be reached form qml by object name "csound"
	engine.rootContext()->setContextProperty("jackReader", jackReader);

	QObject::connect(jackReader, SIGNAL(newBeatBar(int,int)), wsServer, SLOT(handleBeatBar(int,int)) );

	QObject::connect(jackReader, SIGNAL(newLed(int,float)), wsServer, SLOT(handleLed(int,float))) ;

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
