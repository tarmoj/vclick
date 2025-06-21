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
#include "serverdiscovery.h"

#include <QQmlContext>
#include <QIcon>
#include <QFont>


#ifdef Q_OS_IOS
    #include "ios-screen.h"
#endif

#define OSCPORT 57878

// for changes in Qt6, see: https://www.qt.io/blog/qt-extras-modules-in-qt-6
#ifdef Q_OS_ANDROID
    #include <QtCore/private/qandroidextras_p.h>
    #include <QJniEnvironment>
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
    QJniObject activity =  QNativeInterface::QAndroidApplication::context(); //  QtAndroid::androidActivity();
	if (activity.isValid()) {
        QJniObject window = activity.callObjectMethod("getWindow", "()Landroid/view/Window;");

		if (window.isValid()) {
			const int FLAG_KEEP_SCREEN_ON = 128;
			window.callMethod<void>("addFlags", "(I)V", FLAG_KEEP_SCREEN_ON);
		}

        window.callMethod<void>("addFlags", "(I)V", 0x80000000);
        window.callMethod<void>("clearFlags", "(I)V", 0x04000000);
        window.callMethod<void>("setStatusBarColor", "(I)V", 0xa5c9db); // hardcoded color for now. later try to get via QML engine Material.background
        QJniObject decorView = window.callObjectMethod("getDecorView", "()Landroid/view/View;");
        decorView.callMethod<void>("setSystemUiVisibility", "(I)V", 0x00002000);

        QJniEnvironment env; if (env->ExceptionCheck()) { env->ExceptionClear(); } //Clear any possible pending exceptions.
	}
#endif


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

    qmlRegisterType<ServerDiscovery>("Discovery", 1, 0, "ServerDiscovery");

	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
