import QtQuick 2.12
import bsh.backend 1.0

FlickerScreen {
    id: root
    property string title

    GenericListModel {
        id: breadChoiceModel

        NaviagtionMenuItem {
            name: qsTr("Vollkornbrot")
        }
        NaviagtionMenuItem {
            name: qsTr("Weizenmischbrot")
        }
        NaviagtionMenuItem {
            name: qsTr("Weizenmischbrot in Kastenform")
        }
        NaviagtionMenuItem {
            name: qsTr("Weißbrot in Kastenform")
        }
        NaviagtionMenuItem {
            name: qsTr("Weißbrot auf Backblech")
        }
        NaviagtionMenuItem {
            name: qsTr("Fladenbrot")
        }
        NaviagtionMenuItem {
            name: qsTr("Roggenmischbrot mit Hefe")
        }
    }

    EOX6021ProgramDefinition {
        id: meatProgramA
        name: qsTr("Roastbeef, medium")
        tileText: qsTr("Roastbeef, medium")
        tileImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        favoriteTileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
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
            isEnabled: false
        }
        microwave: ProgramIntegerOption {
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
            isEnabled: false
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85]
            isEnabled: true
        }
    }

    EOX6021ProgramDefinition {
        id: meatProgramAT
        name: qsTr("Roastbeef, medium")
        tileText: qsTr("Roastbeef, medium")
        tileImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        favoriteTileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
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
            isEnabled: false
        }
        microwave: ProgramIntegerOption {
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
            isEnabled: true
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85]
            isEnabled: true
        }
    }

    EOX6021ProgramDefinition {
        id: meatProgramS
        name: qsTr("Roastbeef, medium")
        tileText: qsTr("Roastbeef, medium")
        tileImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        favoriteTileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
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
            isEnabled: true
        }
        microwave: ProgramIntegerOption {
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
            isEnabled: false
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85]
            isEnabled: true
        }
    }

    EOX6021ProgramDefinition {
        id: meatProgramST
        name: qsTr("Roastbeef, medium")
        tileText: qsTr("Roastbeef, medium")
        tileImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        favoriteTileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
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
            isEnabled: true
        }
        microwave: ProgramIntegerOption {
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
            isEnabled: true
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85]
            isEnabled: true
        }
    }

    EOX6021ProgramDefinition {
        id: meatProgramM
        name: qsTr("Roastbeef, medium")
        tileText: qsTr("Roastbeef, medium")
        tileImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
        favoriteTileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
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
            isEnabled: false
        }
        microwave: ProgramIntegerOption {
            isEnabled: true
        }
        duration: ProgramIntegerIntervalOption {
            startingValue: 0
            intervalLength: 60
            intervalCount: 24*60
            intervalIndex: 0
            isEnabled: true
        }
        thermometer: ProgramIntegerIntervalOption {
            isEnabled: false
        }
        weightToDuration: ProgramIntegerMappingOption {
            currentIndex: 10
            options: [500, 550, 600, 650, 700, 750, 800, 850, 900, 950, 1000, 1050, 1100, 1150, 1200, 1250, 1300, 1350, 1400, 1450, 1500]
            mappedOptions: [25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85]
            isEnabled: true
        }
    }

    GenericListModel {
        id: meatPreparationChoiceModel

        NaviagtionMenuItem {
            name: qsTr("klassisch")
            firstIcon: "file:resources/siemens/icons/hotair.png"
            referencedItem: meatProgramA
        }
        NaviagtionMenuItem {
            name: qsTr("klassisch auf den Punkt")
            firstIcon: "file:resources/siemens/icons/hotair.png"
            secondIcon: "file:resources/siemens/icons/icn_bratenthermometer.png"
            referencedItem: meatProgramAT
        }
        NaviagtionMenuItem {
            name: qsTr("zart, knusprig")
            firstIcon: "file:resources/siemens/icons/steam_big.png"
            referencedItem: meatProgramS
        }
        NaviagtionMenuItem {
            name: qsTr("schonend auf den Punkt")
            firstIcon: "file:resources/siemens/icons/steam_big.png"
            secondIcon: "file:resources/siemens/icons/icn_bratenthermometer.png"
            referencedItem: meatProgramST
        }
        NaviagtionMenuItem {
            name: qsTr("schnell, knusprig")
            firstIcon: "file:resources/siemens/icons/microwave_big.png"
            referencedItem: meatProgramM
        }
    }

    GenericListModel {
        id: meatChoiceModel

        NaviagtionMenuItem {
            name: qsTr("Rinder-\nschmorbraten")
        }
        NaviagtionMenuItem {
            name: qsTr("Rinderfilet, medium")
        }
        NaviagtionMenuItem {
            name: qsTr("Roastbeef, englisch")
        }
        NaviagtionMenuItem {
            name: qsTr("Roastbeef, medium")
            targetModel: meatPreparationChoiceModel
        }
    }

    GenericListModel {
        id: mealCategoryModel

        NaviagtionMenuItem {
            name: qsTr("Brot")
            tileImage: "file:resources/siemens/images/img_tile_brot.png"
            bgImage: "file:resources/siemens/images/BIG_Kachel_Brot.png"
            targetModel: breadChoiceModel
        }
        NaviagtionMenuItem {
            name: qsTr("Beilagen, Gemüse")
            tileImage: "file:resources/siemens/images/img_tile_gemuese.png"
        }
        NaviagtionMenuItem {
            name: qsTr("Aufläufe,\nSouffles")
            tileImage: "file:resources/siemens/images/img_tile_Kartoffel.png"
        }
        NaviagtionMenuItem {
            name: qsTr("Fleisch")
            tileImage: "file:resources/siemens/images/Fleisch_Kachel.png"
            bgImage: "file:resources/siemens/images/BIG_Kachel_Fleisch.png"
            targetModel: meatChoiceModel
        }
        NaviagtionMenuItem {
            name: qsTr("Fisch")
            tileImage: "file:resources/siemens/images/Fisch_Kachel.png"
        }
    }

    contentExitScale: 1.2
    contentEntryScale: 0.8
    isFlickableClipped: true

    header: Header {
        hasBackButton: true
        title: root.title
        runBackArrowAnimation: true
    }

    flickContent: Row {
        height: 424
        id: programList
        spacing: approximateInNativeResolution(6)
        Repeater {
            model: mealCategoryModel
            delegate: Component {
                ImageTileButton {
                    property NaviagtionMenuItem menuItem: (index >= 0) ? mealCategoryModel.get(index) : null
                    title: menuItem.name
                    imageSource: menuItem.tileImage
                    onClicked: if(menuItem.targetModel) display.push("MealChoiceScreen.qml", {title: title, backgroundSource: menuItem.bgImage, model: menuItem.targetModel})
                }
            }
        }
    }
}
