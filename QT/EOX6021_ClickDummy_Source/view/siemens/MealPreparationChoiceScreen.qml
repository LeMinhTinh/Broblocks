import QtQuick 2.12
import bsh.backend 1.0

FlickerScreen {
    id: root
    property string title
    property GenericListModel model

    contentExitScale: 1.2
    contentEntryScale: 0.8

    header: Header {
        hasBackButton: true
    }

    titleContent: TextLabel {
        visible: root.title
        text: root.title
        fontPixelSize: constants.smallTitleTextSize
        color: themedLightContrastColor
    }

    flickContent: Row {
        id: programList
        spacing: approximateInNativeResolution(6)
        Repeater {
            model: root.model
            delegate: ImageTileButton {
                property NaviagtionMenuItem menuItem: (index >= 0) ? root.model.get(index) : null
                title: menuItem.name
                iconSource: menuItem.firstIcon
                iconSourceSecondary: menuItem.secondIcon
                width: constants.programTileWidth
                height: constants.programTileHeight
                textBackgroundOpacity: 0
                textSideMargin: 6
                textSize: constants.descriptionTextSize
                textAreaHeight: 0.45 * height
                centerInTextArea: true
                textColor: themedLightContrastColor
                hasShine: true
                hasShadow: true
                centerTextHorizontally: true
                backgroundSource: blurredBackground
                backgroundRelativeX: -flickableItem.contentX + contentContainer.x + flickableItem.x
                backgroundRelativeY: contentContainer.y + flickableItem.y
                onClicked: if(menuItem.referencedItem) {
                               backend.setCurrentProgramFromDefinition(menuItem.referencedItem)
                               display.push("MealConfigScreen.qml")
                           }
            }
        }
    }


    footer: Footer {
        backgroundSource: blurredBackground
        hasInfoButton: false
    }
}
