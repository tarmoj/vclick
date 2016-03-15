#include <QApplication>
#include <QQmlApplicationEngine>
#include "oschandler.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

	OscHandler oscServer(8008);

    QQmlApplicationEngine engine;
	engine.rootContext()->setContextProperty("oscServer", &oscServer);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
