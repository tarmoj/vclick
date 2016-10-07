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
#include "oschandler.h"
//#include "settingshandler.h"
#include <QQmlContext>
#include <QIcon>
#include <QFont>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

#ifdef Q_OS_MAC
    app.setFont(QFont("Helvetica")); // otherwise OSX might do strange things
#endif
	OscHandler oscServer(8008);
	//SettingsHandler settings;
	//settings.setSettingsValue("serverAddress","ws:test");
	app.setOrganizationName("eclick"); // for settings
	app.setApplicationName("client");
	app.setWindowIcon(QIcon(":/eclick-client.png"));
    QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("oscServer", &oscServer);
	//engine.rootContext()->setContextProperty("settings", &settings);
#ifdef Q_OS_ANDROID
	engine.rootContext()->setContextProperty("installPath", "assets:/"); // take care in .pro file to install the files
#elif defined(Q_OS_MACX)
    engine.rootContext()->setContextProperty("installPath", "file:///" + QCoreApplication::applicationDirPath() + "/../Resources/sounds/"); // necessary since sounds cannot be played repeatedly from resource
//#elif defined(Q_OS_IOS)
//    engine.rootContext()->setContextProperty("installPath", "file:///" + QCoreApplication::applicationDirPath()+"/sounds/"); // necessary since sounds cannot be played repeatedly from resource
#else
    engine.rootContext()->setContextProperty("installPath", "file:///" + QCoreApplication::applicationDirPath() + "/sounds/"); // necessary since sounds cannot be played repeatedly from resource
#endif
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
