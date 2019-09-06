import QtQuick 2.11

FlickerScreen {
    isFlickableClipped: true
    centerFlickable: true
    flyInInitialContentX: 200
    flyInOvershoot: -400
    contentFadeInDelay: 150
    pushFadeInTime: 800
    flyInOvershootTime: 400
    flyInBouncebackTime: 400
    contentExitScale: 1.3

    header: Header {}

//    4大主菜单
    flickContent: Row {
        spacing: 6
        height: 424

        ImageTileButton {
            imageSource: "file:resources/images/menu.png"
            title: qsTr("Menu")
            onClicked: display.push("ProgramChoiceScreen.qml",
                                    {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/images/menu_big.png"})
        }

        ImageTileButton {
            imageSource: "file:resources/images/setting.png"
            title: qsTr("Setting")
        }

        ImageTileButton {
            imageSource: "file:resources/images/favourite.png"
            title: qsTr("Favourite")
//            onClicked: display.push("FavoritesScreen.qml", {title: title, listModel: backend.favorites})
        }

        ImageTileButton {
            imageSource: "file:resources/images/help.png"
            title: qsTr("Help")
        }
    }
}
