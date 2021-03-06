#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "playerhelper.h"
int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);

    qmlRegisterType<PlayerHelper>("an.qt.PlayerHelper", 1, 0, "PlayerHelper");


    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
