import bsh.eox6021 1.0

//Menu面板(二级菜单)中的所有数据
GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("Mode 0")
        tileIcon: "file:resources/icons/ovenPrograms/mode0.png"
        bgImage: "file:resources/images/config.png"
//                bgImage: ''

//        runningImage: "file:resources/images/background.png"
        favoriteTileImage: "file:resources/ovenPrograms/icons/mode0.png"
//        cant play mp4
        runningVideo: "file:resources/videos/background.avi"
        temperature: ProgramIntegerIntervalOption {
            startingValue: -20
            intervalLength: 2
            intervalCount: 48
            intervalIndex: 0
        }
        quickHeat: ProgramBooleanOption {
            isEnabled: false
        }
        steam: ProgramStringOption {
            currentIndex: 0
            options: ["low", "middle", "high"]
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
            intervalIndex: 0
            isEnabled: false
        }
        thermometer: ProgramBooleanOption {
            isEnabled: false
        }
    }

    EOX6021ProgramDefinition {
        name: qsTr("Mode 1")
        tileIcon: "file:resources/icons/ovenPrograms/mode1.png"

    }

    EOX6021ProgramDefinition {
        name: qsTr("Mode 2")
        tileIcon: "file:resources/icons/ovenPrograms/mode2.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Mode 3")
        tileIcon: "file:resources/icons/ovenPrograms/mode3.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Mode 4")
        tileIcon: "file:resources/icons/ovenPrograms/mode4.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Mode 5")
        tileIcon: "file:resources/icons/ovenPrograms/mode5.png"
    }

}
