#include <QApplication>
#include <QQmlApplicationEngine>
#include "oschandler.h"
//#include "settingshandler.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	OscHandler oscServer(8008);
	//SettingsHandler settings;
	//settings.setSettingsValue("serverAddress","ws:test");
	app.setOrganizationName("eclick"); // for settings
	app.setApplicationName("client");
    QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("oscServer", &oscServer);
	//engine.rootContext()->setContextProperty("settings", &settings);
#ifdef Q_OS_ANDROID
	engine.rootContext()->setContextProperty("installPath", "assets:/"); // take care in .pro file to install the files
#endif
#ifdef Q_OS_MACX
    engine.rootContext()->setContextProperty("installPath", "file:///" + QCoreApplication::applicationDirPath() + "/../Resources/sounds/"); // necessary since sounds cannot be played repeatedly from resource
#else
	engine.rootContext()->setContextProperty("installPath", "file:///" + QCoreApplication::applicationDirPath() + "/sounds/"); // necessary since sounds cannot be played repeatedly from resource
#endif
	engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
