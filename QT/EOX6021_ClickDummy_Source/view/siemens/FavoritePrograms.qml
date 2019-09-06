import bsh.backend 1.0

GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("Hausgemachter Gemüseauflauf")
        tileText: qsTr("Hausgemachter Gemüseauflauf")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/siemens/images/img_tile_gemuese.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        favoriteTileImage: "file:resources/siemens/images/img_tile_gemuese.png"
        //runningVideo: "file:resources/siemens/videos/Heatwaves.mp4"
        temperature: ProgramIntegerIntervalOption {
            startingValue: 60
            intervalLength: 5
            intervalCount: 48
            intervalIndex: 24
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
            intervalIndex: 45
            isEnabled: true
        }
        thermometer: ProgramIntegerIntervalOption {
            startingValue: 40
            intervalLength: 5
            intervalCount: 13
            intervalIndex: 0
            isEnabled: false
        }
    }
    EOX6021ProgramDefinition {
        name: qsTr("Roggenmisch Bauernbrot")
        tileText: qsTr("Roggenmisch Bauernbrot")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/siemens/images/img_tile_brot.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Brot.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Brot.png"
        favoriteTileImage: "file:resources/siemens/images/img_tile_brot.png"
        //runningVideo: "file:resources/siemens/videos/Heatwaves.mp4"
        temperature: ProgramIntegerIntervalOption {
            startingValue: 60
            intervalLength: 5
            intervalCount: 48
            intervalIndex: 48
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
            intervalIndex: 150
            isEnabled: true
        }
        thermometer: ProgramIntegerIntervalOption {
            startingValue: 40
            intervalLength: 5
            intervalCount: 13
            intervalIndex: 0
            isEnabled: false
        }
    }
    EOX6021ProgramDefinition {
        name: qsTr("Ofenkartoffeln")
        tileText: qsTr("Ofenkartoffeln")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/siemens/images/img_tile_Kartoffel.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Kartoffel.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Kartoffel.png"
        favoriteTileImage: "file:resources/siemens/images/img_tile_Kartoffel.png"
        //runningVideo: "file:resources/siemens/videos/Heatwaves.mp4"
        temperature: ProgramIntegerIntervalOption {
            startingValue: 60
            intervalLength: 5
            intervalCount: 48
            intervalIndex: 24
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
            intervalIndex: 30
            isEnabled: true
        }
        thermometer: ProgramIntegerIntervalOption {
            startingValue: 40
            intervalLength: 5
            intervalCount: 13
            intervalIndex: 0
            isEnabled: false
        }
    }
}
