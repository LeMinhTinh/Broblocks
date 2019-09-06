import QtQuick 2.11

FlickerScreen {
    isFlickableClipped: true
    centerFlickable: true
/*    flyInInitialContentX: 200
    flyInOvershoot: -400
    contentFadeInDelay: 150
    pushFadeInTime: 800
    flyInOvershootTime: 400
    flyInBouncebackTime: 400*/
    flyInInitialContentX: -600
    flyInOvershoot: 400
    contentFadeInDelay: 200
    pushFadeInTime: 1200
    flyInOvershootTime: 600
    flyInBouncebackTime: 600    
    contentExitScale: 1.3

    header: Header {}

//    4大主菜单
    flickContent: Row {
        spacing: 6
        height: 424

        ImageTileButton {
            imageSource: "file:resources/images/washing1.png"
            title: qsTr("Wash")
	    
            onClicked: display.push("ProgramChoiceScreen.qml",
                                    {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/images/menu_big.png"})
        }

        ImageTileButton {
            imageSource: "file:resources/images/washing_dry.png"
            title: qsTr("Wash & Dry")
        }

        ImageTileButton {
            imageSource: "file:resources/images/drying.png"
            title: qsTr(" Dry")
//            onClicked: display.push("FavoritesScreen.qml", {title: title, listModel: backend.favorites})
        }
	

/*        ImageTileButton {
            imageSource: "file:resources/images/help.png"
            title: qsTr("Help")
        }
*/	
    }
}
