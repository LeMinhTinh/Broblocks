import bsh.backend 1.0

GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("Roggenmischbrot")
        tileText: qsTr("Roggen-\nmischbrot")
        tileImage: "file:resources/siemens/images/img_tile_brot.png"
        runningImage: "file:resources/siemens/images/BG_brot_running.png"
        isMeal: true
        temperature: ProgramIntegerIntervalOption {
            startingValue: 60
            intervalLength: 5
            intervalCount: 48
            intervalIndex: 20
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
            isEnabled: true
        }
        thermometer: ProgramIntegerIntervalOption {
            startingValue: 40
            intervalLength: 1
            intervalCount: 60
            intervalIndex: 0
            isEnabled: false
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1050, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60]
            isEnabled: false
        }
    }

    EOX6021ProgramDefinition {
        name: qsTr("Brötchen")
        tileText: qsTr("Brötchen")
        tileImage: "file:resources/siemens/images/img_tile_semmeln.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Kuchen")
        tileText: qsTr("Kuchen")
        tileImage: "file:resources/siemens/images/img_tile_kuchen.png"
    }
}
