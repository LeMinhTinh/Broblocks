//------------------------------------------
// Platform independent click dummy entry point

#if defined(_WIN32)
    #define WIN32_LEAN_AND_MEAN
    #include <windows.h>
#endif

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDir>
#include <QFont>
#include <QFontDatabase>
#include <QLocale>
#include <QDebug>
#include <QSettings>
#include <QCursor>
#include <QScreen>
#include <QThread>
#include <qtranslator.h>  //sunjie

#include "generic_list_model.h"
#include "program_option_types.h"
#include "eox6021_program_definition.h"
#include "eox6021_program.h"
#include "eox6021_backend.h"
#include "navigation_menu_item.h"

int main(int argc, char *argv[])
{
    // might be useful for better low spec system compatibility
    //if (!qEnvironmentVariableIsSet("QT_OPENGL")) qputenv("QT_OPENGL", "angle");

    #if defined(_WIN32)
        // Enable simple console output for windows console
        if (AttachConsole(ATTACH_PARENT_PROCESS)) {
            freopen("CONOUT$", "w", stdout);
            freopen("CONOUT$", "w", stderr);
        }
    #endif
    QTranslator translator;
    translator.load(":/view/siemens/tr_zh.qm");

    // Read configuration
    QSettings modeSettings(QFileInfo("resources/mode.ini").absoluteFilePath(), QSettings::IniFormat);
    QString mode(modeSettings.value("mode").toString());
    QSettings settings(QFileInfo("resources/" + mode + "/configuration.ini").absoluteFilePath(), QSettings::IniFormat);
	
    // Enable qt virtual keyboard
    QLocale::setDefault(QLocale::German);
    qputenv("QML2_IMPORT_PATH", "qrc:/view");
    qputenv("QT_VIRTUALKEYBOARD_STYLE", "bsh");
    qputenv("QT_VIRTUALKEYBOARD_LAYOUT_PATH", "qrc:/view/QtQuick/VirtualKeyboard/layouts");
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    // Create Application after environment is setup
    QGuiApplication app {argc, argv};

    app.installTranslator(&translator);  //sunjie

    // Load fonts
    QStringList fontFiles = QDir("resources/" + mode + "/font").entryList(QStringList("*.ttf"));
    for(const auto& font: fontFiles) {
        QFontDatabase::addApplicationFont(QFileInfo("resources/" + mode + "/font/" + font).absoluteFilePath());
    }
    QGuiApplication::setFont(QFont(settings.value("defaultFont").toString()));
    if (!QGuiApplication::font().exactMatch()) {
        qWarning() << "Font (" << settings.value("defaultFont").toString() << ") could not be loaded.";
    }

    // Calculate ui scaling to replicate emulated display
    QGuiApplication::setAttribute(Qt::AA_DisableHighDpiScaling);
    QGuiApplication::setAttribute(Qt::AA_UseHighDpiPixmaps);
    qputenv("QT_AUTO_SCREEN_FACTOR", "0");
    // Give the user a little time to move the mouse cursor to the desired screen
    QThread::msleep(500);
    QScreen* screen {QGuiApplication::screenAt(QCursor::pos())};
    if (screen == nullptr) screen = QGuiApplication::screens().at(0);
    double emulatedDisplayPixelDensity {1.0 / settings.value("pixelSizeMM").toDouble()};
    double screenWidthMM {screen->physicalSize().width()};
    double screenHeightMM {screen->physicalSize().height()};
    int screenResolutionX {screen->size().width()};
    int screenResolutionY {screen->size().height()};
    if (settings.contains("screenResolutionX")) screenResolutionX = settings.value("screenResolutionX").toInt();
    if (settings.contains("screenResolutionY")) screenResolutionY = settings.value("screenResolutionY").toInt();
    if (settings.contains("screenWidthMM")) screenWidthMM = settings.value("screenWidthMM").toDouble();
    if (settings.contains("screenHeightMM")) screenHeightMM = settings.value("screenHeightMM").toDouble();
    double currentDisplayPixelDensity {0.5 * (screenResolutionX / screenWidthMM + screenResolutionY / screenHeightMM)};
    double scaleFactor = currentDisplayPixelDensity / emulatedDisplayPixelDensity;
    qDebug() << "Display properties:";
    qDebug() << "Width x Height (mm):" << screenWidthMM << "x" << screenHeightMM;
    qDebug() << "Resolution (px):    " << screenResolutionX << "x" << screenResolutionY;
    qDebug() << "UI Scale factor:    " << scaleFactor;

    // Enable qml to create the backend and related types
    qmlRegisterType<BSH::GenericListModel>("bsh.backend", 1, 0, "GenericListModel");
    qmlRegisterType<BSH::ProgramIntegerIntervalOption>("bsh.backend", 1, 0, "ProgramIntegerIntervalOption");
    qmlRegisterType<BSH::ProgramIntegerOption>("bsh.backend", 1, 0, "ProgramIntegerOption");
    qmlRegisterType<BSH::ProgramIntegerMappingOption>("bsh.backend", 1, 0, "ProgramIntegerMappingOption");
    qmlRegisterType<BSH::ProgramStringOption>("bsh.backend", 1, 0, "ProgramStringOption");
    qmlRegisterType<BSH::ProgramBooleanOption>("bsh.backend", 1, 0, "ProgramBooleanOption");
    qRegisterMetaType<BSH::EOX6021ProgramDefinition*>("EOX6021ProgramDefinition*");
    qmlRegisterType<BSH::EOX6021ProgramDefinition>("bsh.backend", 1, 0, "EOX6021ProgramDefinition");
    qRegisterMetaType<BSH::NaviagtionMenuItem*>("NaviagtionMenuItem*");
    qmlRegisterType<BSH::NaviagtionMenuItem>("bsh.backend", 1, 0, "NaviagtionMenuItem");
    qmlRegisterType<BSH::EOX6021Program>("bsh.backend", 1, 0, "EOX6021Program");
    qmlRegisterType<BSH::EOX6021BackEnd>("bsh.backend", 1, 0, "EOX6021BackEnd");

    // Load and show the main window.
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("_xShift", settings.value("xShift", 0).toDouble());
    engine.rootContext()->setContextProperty("_yShift", settings.value("yShift", 0).toDouble());
    engine.rootContext()->setContextProperty("_mm", emulatedDisplayPixelDensity);
    engine.rootContext()->setContextProperty("_uiScale", scaleFactor);
    engine.load("qrc:/view/" + settings.value("rootQML").toString());
    return app.exec();
}
