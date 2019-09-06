import QtQuick 2.12
import bsh.backend 1.0

Item {
    property alias mainCategoryModel: mainCategoryModel
    GenericListModel {
        id: mainCategoryModel

        SettingsEntryModel {
            target: "SettingsEntryQuick.qml"
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_light_on.png",
                         "title": "Lichter / Display",
                         "model": lightModel}
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_sound_on.png",
                         "title": "Töne"}
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_hardware.png",
                         "title": "Hardwareeinstellungen"}
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_misc.png",
                         "title": "Personalisierung"}
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_misc.png",
                         "title": "Home Connect"}
        }

        SettingsEntryModel {
            target: "SettingsEntryCategory.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_time.png",
                         "title": "Zeit / Datum / Timer",
                         "model": timeModel}
        }

        SettingsEntryModel {
            target: "SettingsEntryDummy.qml"
            properties: {"iconSource": "file:resources/siemens/icons/settings_language.png",
                         "title": "Sprache",
                         "value": "Deutsch"}
        }
    }

    property alias lightModel: lightModel
    GenericListModel {
        id: lightModel

        SettingsEntryModel {
            target: "SettingsEntryBool.qml"
            properties: {"title": "Nachtabdunklung"}
        }

        SettingsEntryModel {
            target: "SettingsEntryStringList.qml"
            properties: {"title": "Displayhelligkeit",
                         "option": backend.displayBrightness}
        }

        SettingsEntryModel {
            target: "SettingsEntryBool.qml"
            properties: {"title": "Beleuchtung"}
        }

        SettingsEntryModel {
            target: "SettingsEntryDummy.qml"
            properties: {"title": "Buttonhelligkeit",
                         "value": "gering"}
        }

        SettingsEntryModel {
            target: "SettingsEntryDummy.qml"
            properties: {"title": "Display Standby",
                         "value": "nach 5 Minuten"}
        }
    }

    property alias timeModel: timeModel
    GenericListModel {
        id: timeModel

        SettingsEntryModel {
            target: "SettingsEntryBool.qml"
            properties: {"title": "24h Zeitformat"}
        }

        SettingsEntryModel {
            target: "SettingsEntryTime.qml"
            properties: {"title": "Uhrzeit"}
        }

        SettingsEntryModel {
            target: "SettingsEntryRadio.qml"
            properties: {"title": "Uhranzeige im Standby",
                         "description": "Entscheiden Sie, ob und welche Uhr im Standby angezeigt wird:",
                         "option": backend.standbyClockMode}
        }

        SettingsEntryModel {
            target: "SettingsEntryDummy.qml"
            properties: {"title": "Datumsformat",
                         "value": "europäisch (TT.MM.JJJJ)"}
        }

        SettingsEntryModel {
            target: "SettingsEntryDate.qml"
            properties: {"title": "Datum"}
        }
    }
}
