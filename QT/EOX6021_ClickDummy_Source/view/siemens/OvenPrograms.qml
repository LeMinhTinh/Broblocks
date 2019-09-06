import bsh.backend 1.0

GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("4D Heißluft")
        tileText: qsTr("4D Heißluft")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/4D Heissluft.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        favoriteTileImage: "file:resources/siemens/images/Heizarten_Kachel.png"
        runningVideo: "file:resources/siemens/videos/Heatwaves_red.mp4"
        temperature: ProgramIntegerIntervalOption {
            startingValue: 30
            intervalLength: 5
            intervalCount: 54
            intervalIndex: 26
        }
        quickHeat: ProgramBooleanOption {
            isEnabled: false
        }
        steam: ProgramStringOption {
            currentIndex: 0
            options: ["gering", "mittel", "stark"]
            isEnabled: false
        }
        microwave: ProgramIntegerOption {
            currentIndex: 0
            options: [90, 180, 360]
            isEnabled: false
        }
        duration: ProgramIntegerIntervalOption {
            startingValue: 0
            intervalLength: 60
            intervalCount: 24*60
            intervalIndex: 0
            isEnabled: false
        }

        thermometer: ProgramIntegerIntervalOption {
            startingValue: 39
            intervalLength: 1
            intervalCount: 61
            intervalIndex: 0
            isEnabled: false
        }
    }

    EOX6021ProgramDefinition {
        name: qsTr("Ober-/Unterhitze")
        tileText: qsTr("Ober-/ Unterhitze")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Heißluft ECO")
        tileText: qsTr("Heißluft ECO")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Heissluft ECO.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Ober-/Unterhitze ECO")
        tileText: qsTr("Ober-/ Unterhitze\nECO")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze ECO.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Umluft")
        tileText: qsTr("Umluft")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_Umluft.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Auftauen")
        tileText: qsTr("Auftauen")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_auftauen.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Dämpfen")
        tileText: qsTr("Dämpfen")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_daempfen.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Dämpfen Heißluft")
        tileText: qsTr("Dämpfen Heißluft")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_daempfen-heissluft.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Dörren")
        tileText: qsTr("Dörren")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_doerren.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Drehspieß")
        tileText: qsTr("Drehspieß")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_drehspiess.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Geschirrvorwärmen")
        tileText: qsTr("Geschirr\nvorwärmen")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_Geschirr-vorwaermen.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Grill groß")
        tileText: qsTr("Grill groß")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_grill-gross.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Grill klein")
        tileText: qsTr("Grill klein")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_grill-klein.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Umluft grillen")
        tileText: qsTr("Umluft grillen")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_umluft-grillen.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Heißluft")
        tileText: qsTr("Heißluft")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_heissluft.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Intensivhitze")
        tileText: qsTr("Intensivhitze")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_intensivhitze.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Oberhitze")
        tileText: qsTr("Oberhitze")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_oberhitze.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Ober-/Unterhitze (Spz)")
        tileText: qsTr("Ober-/ Unterhitze\n(Spz)")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_ober-unterhitze-spezial.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Pizzastufe")
        tileText: qsTr("Pizzastufe")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_pizzastufe.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Sanftgaren")
        tileText: qsTr("Sanftgaren")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/icn_sanftgaren.png"
    }
}
