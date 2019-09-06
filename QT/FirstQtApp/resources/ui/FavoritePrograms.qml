import bsh.eox6021 1.0

GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("Homemade vegetable casserole")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/images/img_tile_gemüse.png"
        bgImage: "file:resources/images/img_BG_heizarten.png"
        runningImage: "file:resources/images/img_BG_running.png"
        favoriteTileImage: "file:resources/images/img_tile_gemüse.png"
        runningVideo: "file:resources/videos/Heatwaves.mp4"
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
            intervalLength: 1
            intervalCount: 24*60
            intervalIndex: 45
            isEnabled: true
        }
        thermometer: ProgramBooleanOption {
            isEnabled: false
        }
    }
    EOX6021ProgramDefinition {
        name: qsTr("Rye mixed farmhouse bread")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/images/img_tile_brot.png"
        bgImage: "file:resources/images/img_BG_heizarten.png"
        runningImage: "file:resources/images/img_BG_running.png"
        favoriteTileImage: "file:resources/images/img_tile_brot.png"
        runningVideo: "file:resources/videos/Heatwaves.mp4"
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
            intervalLength: 1
            intervalCount: 24*60
            intervalIndex: 150
            isEnabled: true
        }
        thermometer: ProgramBooleanOption {
            isEnabled: false
        }
    }
    EOX6021ProgramDefinition {
        name: qsTr("baked beans")
        isFavorite: true
        useDarkTheme: false
        tileImage: "file:resources/images/img_tile_Kartoffel.png"
        bgImage: "file:resources/images/img_BG_heizarten.png"
        runningImage: "file:resources/images/img_BG_running.png"
        favoriteTileImage: "file:resources/images/img_tile_Kartoffel.png"
        runningVideo: "file:resources/videos/Heatwaves.mp4"
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
            intervalLength: 1
            intervalCount: 24*60
            intervalIndex: 30
            isEnabled: true
        }
        thermometer: ProgramBooleanOption {
            isEnabled: false
        }
    }
}
