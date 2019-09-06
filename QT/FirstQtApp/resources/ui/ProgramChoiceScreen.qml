import QtQuick 2.11
import bsh.eox6021 1.0


//子菜单界面(程序选择)
FlickerScreen {
    id: root
    property string title
    property GenericListModel listModel

    initialFooterBottomMargin: -25
    footerPushFadeInTime: pushFadeInTime
    moveInStartPosition: 300
    contentExitScale: 1.2
    initialBackgroundScale: 1.0
    targetBackgroundScale: 1.05

    header: Header {
        hasBackButton: true
        title: qsTr("Wash")
    }

    titleContent: TextLabel {
        visible: false//root.title
        text: root.title//+' ('+listModel.rowCount()+')'
        fontPixelSize: 38//constants.titleSize
        color: themedLightContrastColor
	//horizontalAlignment: Text.AlignHCenter
	//anchors.centerIn: parent;
    }

    flickContent: Row {
        id: programList
        spacing: 6
        Repeater {
            model: listModel
            delegate: ProgramTileButton {
                programDefinition: (index >= 0) ? listModel.get(index) : null
                backgroundSource: blurredBackground
                backgroundRelativeX: -flickableItem.contentX + content.x + flickableItem.x
                backgroundRelativeY: content.y + flickableItem.y
                onClicked: {
                    if (programDefinition.bgImage) {
                        backend.setCurrentProgramFromDefinition(programDefinition)
                        programDefinition.name == "Favorites"? display.push("FavoritesScreen.qml", {title: title, listModel: backend.favorites}): display.push("ProgramConfigScreen.qml")
                    }
                }
            }
        }
    }


/*sunjie    footer: Footer {
        backgroundSource: blurredBackground
    }*/
}
