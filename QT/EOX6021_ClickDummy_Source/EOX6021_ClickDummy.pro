QT += quick
CONFIG += c++11 object_parallel_to_source qtquickcompiler
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += *.cpp
HEADERS += *.h
RESOURCES += qml.qrc \
    translator.qrc
OTHER_FILES += \
    resources/mode.ini \
    resources/siemens/configuration.ini \
    resources/siemens/font/* \
    resources/siemens/icons/* \
    resources/siemens/images/* \
    resources/QtQuick/VirtualKeyboard/layouts/de_DE/* \
    resources/QtQuick/VirtualKeyboard/Styles/bsh/*

lupdate_only{
 SOURCES += view/siemens/*.qml
 }
TRANSLATIONS +=view/siemens/tr_zh.ts \
               view/siemens/tr_en.ts \
               view/siemens/tr_de.ts

DISTFILES +=
