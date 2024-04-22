/*
	Copyright (C) 2016 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of vClick.

	vClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	vClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with vClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#ifdef CONSOLE_APP
#include <QCoreApplication>
#else
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include <QFont>
#endif
#include "wsserver.h"
#include "csengine.h"
#include <QThread>
#include <QCommandLineParser>


#ifdef Q_OS_ANDROID

#include <QtAndroidExtras/QtAndroid>

bool checkPermission() { // requires >= Qt 5.10
	QtAndroid::PermissionResult r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
	if(r == QtAndroid::PermissionResult::Denied) {
		QtAndroid::requestPermissionsSync( QStringList() << "android.permission.WRITE_EXTERNAL_STORAGE" );
		r = QtAndroid::checkPermission("android.permission.WRITE_EXTERNAL_STORAGE");
		if(r == QtAndroid::PermissionResult::Denied) {
			 return false;
		}
   }
   return true;
}
#endif

#ifdef USE_JACK
	#include "jackreader.h"
#endif

#define OSC_PORT 57878

// see https://doc.qt.io/qt-5/qapplication.html#details for supporting both gui and console
// for now just rewrite as console app

int main(int argc, char *argv[])
{

#ifdef CONSOLE_APP
	QCoreApplication app(argc, argv);
#else
    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);

	//app.setFont(QFont("Helvetica")); // otherwise OSX might do strange things
	app.setWindowIcon(QIcon(":/vclick-server.png"));
#endif


	app.setOrganizationName("vclick"); // for settings
	app.setApplicationName("server");
    app.setApplicationVersion(APP_VERSION);

    qDebug() << "vClick Server, version " << APP_VERSION;

    // parse command line
    QCommandLineParser parser;
    parser.setApplicationDescription("vCLick Server command line options");
    parser.addHelpOption();
    parser.addVersionOption();

    QCommandLineOption port(QStringList() << "p" << "port",
                            QCoreApplication::translate("main", "Websocket port that the server will be listening to"),
                            QCoreApplication::translate("main", "port"));
    parser.addOption(port);

    QCommandLineOption scoreFiles(QStringList() << "s" << "score-files",
                                  QCoreApplication::translate("main", "Scorefiles (if not read from settings) , separated by semicolon"),
                                  QCoreApplication::translate("main", "scoreFiles"));
    parser.addOption(scoreFiles);

    QCommandLineOption noOscOption (QStringList() << "no-osc" << "n",
                                    QCoreApplication::translate("main", "Do not send OSC messages, do not register oscClients"));
    parser.addOption(noOscOption);

    // Process the actual command line arguments given by the user
    parser.process(app);

    qDebug() << "Options: " << parser.isSet(noOscOption) << parser.value(port) << parser.value(scoreFiles) ;



#ifdef Q_OS_OSX
    QString pluginsPath = QApplication::applicationDirPath() + "/../Frameworks/CsoundLib64.framework/Versions/6.0/Resources/Opcodes64";
    qDebug()<<" Csound plugins in: " << pluginsPath;
    setenv("OPCODE6DIR64", pluginsPath.toLocal8Bit() ,1);
#endif

#ifdef Q_OS_WIN
    QString env = "OPCODE6DIR64="+QApplication::applicationDirPath() + "/plugins64";
    qDebug()<<"putenv " << env;
    putenv(env.toLocal8Bit() );
#endif

#ifdef Q_OS_ANDROID
	checkPermission();
	QString pluginsPath = QApplication::applicationDirPath() + "/lib/";
	qDebug()<<" Csound plugins in: " << pluginsPath;
	setenv("OPCODE6DIR64", pluginsPath.toLocal8Bit() ,1);
#endif


	// create csound thread, must be before WsServer
	QThread * csoundThread = new QThread();
	CsEngine * csound = new CsEngine();
	csound->moveToThread(csoundThread);

	WsServer *wsServer;

    quint16 wsPort = parser.isSet(port) ?  parser.value(port).toUInt() :  6006;
    QString userScoreFiles = parser.isSet(scoreFiles) ? parser.value(scoreFiles) : "";
    wsServer = new WsServer(wsPort, userScoreFiles);

#ifdef USE_JACK
	JackReader *jackReader = new JackReader();  // started from qml
#endif



	QObject::connect(csoundThread, &QThread::finished, csound, &CsEngine::deleteLater);
	QObject::connect(csoundThread, &QThread::finished, csoundThread, &QThread::deleteLater);
	QObject::connect(&app, SIGNAL(aboutToQuit()), csound, SLOT(stop()) ); // BETTER: closeEvent somwhere, but no MainWindow...


    QObject::connect(csound,&CsEngine::newBeatBar, wsServer, &WsServer::handleBeatBar );
	QObject::connect(csound,&CsEngine::newLed, wsServer, &WsServer::handleLed );
	QObject::connect(csound,&CsEngine::newTempo, wsServer, &WsServer::handleTempo );
	QObject::connect(csound,&CsEngine::newNotification, wsServer, &WsServer::handleNotification );
	QObject::connect(csound,&CsEngine::csoundMessage, wsServer, &WsServer::csoundMessage );
    QObject::connect(csound,&CsEngine::newStartMessage, wsServer, &WsServer::sendDawStartCommand );

	QObject::connect(wsServer ,&WsServer::newOscPort, csound, &CsEngine::setOscPort );



#ifdef CONSOLE_APP
	QObject::connect(wsServer, &WsServer::stop, csound, &CsEngine::stop);
	QObject::connect(wsServer, &WsServer::start, csound, &CsEngine::startScore);
	QObject::connect(wsServer, &WsServer::newStartBar, csound, &CsEngine::setStartBar);
	QObject::connect(wsServer, &WsServer::updateOscAddresses, csound, &CsEngine::setOscAddresses);
    QObject::connect(wsServer, &WsServer::startTime, csound, &CsEngine::startTime);
#endif

	//wsServer->setOscPort(87878);
	csoundThread->start();


#ifndef CONSOLE_APP
	// QML engine and connections
	QQmlApplicationEngine engine;
	//QQuickStyle::setStyle("Material");
	//bind object before load
	engine.rootContext()->setContextProperty("wsServer", wsServer); // forward c++ object that can be reached form qml by object name "wsSerrver"
	engine.rootContext()->setContextProperty("cs", csound);

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

#endif



#ifdef USE_JACK
#ifndef CONSOLE_APP
	engine.rootContext()->setContextProperty("jackReader", jackReader);
#endif
	QObject::connect(jackReader, SIGNAL(newBeatBar(int,int)), wsServer, SLOT(handleBeatBar(int,int)) );
	QObject::connect(jackReader, SIGNAL(newLed(int,float)), wsServer, SLOT(handleLed(int,float))) ;
	QObject::connect(jackReader,  SIGNAL(newTempo(double)), wsServer, SLOT(handleTempo(double)));

#endif

    return app.exec();
}
