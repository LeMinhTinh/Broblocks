#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "LaundryModel.h"
#include "ModeList.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<LaundryModel>("Laundry", 1, 0, "LaundryModel");
    qmlRegisterUncreatableType<ModeList>("Laundry", 1, 0, "Model",
                                         QStringLiteral("ModeList should not be created in QML"));
    ModeList modeList;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty(QStringLiteral("modeList"), &modeList);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
