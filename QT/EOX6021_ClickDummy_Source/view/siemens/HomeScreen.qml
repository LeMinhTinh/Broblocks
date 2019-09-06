import QtQuick 2.12

FlickerScreen {
    id: root
    isFlickableClipped: true
    
    pushFadeInTime: 666
    headerFadeTime: fadeInTime
    contentExitScale: 1.2
    //contentEntryScale: 0.8

    // TODO poor synchonization workaround
    property bool runFlyInAnimation: false
    Timer {
        running: true
        onTriggered: runFlyInAnimation = true
        interval: 1
    }

    header: Header {
        showSettingsIcon: true
    }
    NumberAnimation {
        id: settingsButtonRotation
        target: header.settingsButton
        property: "rotation"
        from: 0
        to: 135
        duration: 300
    }
    Connections {
        target: header.settingsButton
        onClicked: {
            settingsButtonRotation.start()
            settingsOverlay.show()
        }
    }

    flickContent: Row {
        id: content
        spacing: approximateInNativeResolution(6)

        ImageTileButton {
            id: heatingButton
            imageSource: "file:resources/siemens/images/washing1.png"
            title: qsTr("Wash")
            onClicked: display.push("ProgramChoiceScreen.qml",
                                    {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"})
            property int index: 0
            hasFlyInAnimation: true
            runFlyInAnimation: root.runFlyInAnimation
        }

        ImageTileButton {
            id: microwaveButton
            imageSource: "file:resources/siemens/images/washing_dry.png"
            title: qsTr("Wash & Dry")
            property int index: 1
            hasFlyInAnimation: true
            runFlyInAnimation: root.runFlyInAnimation
        }

        ImageTileButton {
            id: mealButton
            imageSource: "file:resources/siemens/images/drying.png"
            title: qsTr("Dry")
            onClicked: display.push("MealCategoryScreen.qml", {title: title})
            property int index: 2
            hasFlyInAnimation: true
            runFlyInAnimation: root.runFlyInAnimation
        }
/*
        ImageTileButton {
            id: favoriteButton
            imageSource: "file:resources/siemens/images/Favoriten_Kachel.png"
            title: qsTr("Favoriten")
            onClicked: display.push("FavoritesScreen.qml", {title: title, listModel: backend.favorites})
            property int index: 3
            hasFlyInAnimation: true
            runFlyInAnimation: root.runFlyInAnimation
        }

        ImageTileButton {
            id: cleaningButton
            imageSource: "file:resources/siemens/images/img_tile_selbstreinigung.png"
            title: qsTr("Selbstreinigung")
            onClicked: display.push("ProgramChoiceScreen.qml",
                                    {title: title, listModel: backend.cleaningPrograms, backgroundSource: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"})
            property int index: 4
            hasFlyInAnimation: true
            runFlyInAnimation: root.runFlyInAnimation
        }*/
    }
}
