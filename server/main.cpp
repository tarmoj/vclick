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

#ifdef Q_OS_OSX
    QString pluginsPath = QApplication::applicationDirPath() + "/../Frameworks/CsoundLib64.framework/Versions/6.0/Resources/Opcodes64";
    qDebug()<<" Csound plugins in: " << pluginsPath;
    setenv("OPCODE6DIR64", pluginsPath.toLocal8Bit() ,1);
#endif

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
	QObject::connect(&app, SIGNAL(aboutToQuit()), csound, SLOT(stop()) ); // BETTER: closeEvent somwhere, but no MainWindow...


	QObject::connect(csound,&CsEngine::newBeatBar, wsServer, &WsServer::handleBeatBar ); // QT5 style of connection
	QObject::connect(csound,&CsEngine::newLed, wsServer, &WsServer::handleLed );
	QObject::connect(csound,&CsEngine::newTempo, wsServer, &WsServer::handleTempo );
	QObject::connect(csound,&CsEngine::newNotification, wsServer, &WsServer::handleNotification );

	QObject::connect(csound,&CsEngine::csoundMessage, wsServer, &WsServer::csoundMessage );

	csoundThread->start();

	// QML engine and connections

    QQmlApplicationEngine engine;
	//bind object before load
	engine.rootContext()->setContextProperty("wsServer", wsServer); // forward c++ object that can be reached form qml by object name "wsSerrver"
	engine.rootContext()->setContextProperty("cs", csound);

#ifdef Q_OS_LINUX
	engine.rootContext()->setContextProperty("jackReader", jackReader);
	QObject::connect(jackReader, SIGNAL(newBeatBar(int,int)), wsServer, SLOT(handleBeatBar(int,int)) );
	QObject::connect(jackReader, SIGNAL(newLed(int,float)), wsServer, SLOT(handleLed(int,float))) ;
	QObject::connect(jackReader,  SIGNAL(newTempo(double)), wsServer, SLOT(handleTempo(double)));

#endif

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
