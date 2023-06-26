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
#include <QApplication>
#include <QQmlApplicationEngine>

#ifdef USE_OSC
#include "oschandler.h"
#endif

#include <QQmlContext>
#include <QIcon>
#include <QFont>

#ifdef Q_OS_IOS
    #include "ios-screen.h"
#endif

#define OSCPORT 57878

#ifdef Q_OS_ANDROID
	#include <QtAndroid>
	#include <QAndroidJniEnvironment>
#endif


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

#ifdef Q_OS_MAC
    app.setFont(QFont("Helvetica")); // otherwise OSX might do strange things
#endif

#ifdef Q_OS_IOS
    IosScreen screen;
    screen.setTimerDisabled();
#endif

#ifdef Q_OS_ANDROID
	//keep screen on:
	QAndroidJniObject activity = QtAndroid::androidActivity();
	if (activity.isValid()) {
		QAndroidJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

		if (window.isValid()) {
			const int FLAG_KEEP_SCREEN_ON = 128;
			window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
		}
		QAndroidJniEnvironment env; if (env->ExceptionCheck()) { env->ExceptionClear(); } //Clear any possible pending exceptions.
	}
#endif


	//SettingsHandler settings;
	//settings.setSettingsValue("serverAddress","ws:test");
	app.setOrganizationName("vclick"); // for settings
	app.setApplicationName("client");
	app.setWindowIcon(QIcon(":/vclick-client.png"));
    app.setApplicationVersion(APP_VERSION);
    QQmlApplicationEngine engine;

#ifdef USE_OSC
    OscHandler oscServer(static_cast<quint16>(OSCPORT));
    engine.rootContext()->setContextProperty("oscServer", &oscServer);
# else
    engine.rootContext()->setContextProperty("oscServer", nullptr);
#endif

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
