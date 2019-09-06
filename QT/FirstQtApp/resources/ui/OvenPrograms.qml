import bsh.eox6021 1.0

//Menu面板(二级菜单)中的所有数据
GenericListModel {

    EOX6021ProgramDefinition {
        name: qsTr("Cotton")
        tileImage: "file:resources/images/WashPrograms/programTileCottonBGTile.png"
        bgImage: "file:resources/images/config.png"
        //bgImage: ''

        runningImage: "file:resources/images/background.png"
        //sunjie favoriteTileImage: "file:resources/WashPrograms/images/programTileCottonBGTile.png"
	favoriteTileImage: "file:resources/images/favourite.png"
//        cant play mp4
        runningVideo: "file:resources/videos/background.avi"
        temperature: ProgramIntegerIntervalOption {
            startingValue: 40 //-20
            intervalLength: 5 //2
            intervalCount: 8
            intervalIndex: 0
        }
        spinspeed: ProgramIntegerIntervalOption {
            startingValue: 600 //-20
            intervalLength: 100 //2
            intervalCount: 8
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
        name: qsTr("Easy Care")
        tileImage: "file:resources/images/WashPrograms/programTileEasyCareBGTile.png"

    }

    EOX6021ProgramDefinition {
        name: qsTr("Jeans")
        tileImage: "file:resources/images/WashPrograms/programTileJeansBGTile.png"
	bgImage: "file:resources/images/config.png"
	
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
        name: qsTr("Mix")
        tileImage: "file:resources/images/WashPrograms/programTileMixBGTile.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("My Time")
        tileImage: "file:resources/images/WashPrograms/programTileShirtsBGTile.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Synthesis")
        tileImage: "file:resources/images/WashPrograms/programTileDelicatesBGTile.png"
    }

    EOX6021ProgramDefinition {
        name: qsTr("Favorites")
        tileImage: "file:resources/images/img_tile_favoriten.png"
        bgImage: "file:resources/images/config.png"
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

/*    ImageTileButton {
         imageSource: "file:resources/images/img_tile_favoriten.png"
         title: qsTr("Favorites")
         onClicked: display.push("FavoritesScreen.qml",
                                     {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/images/menu_big.png"})
         }
*/
}
