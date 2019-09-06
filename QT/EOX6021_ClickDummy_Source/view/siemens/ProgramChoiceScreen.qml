import QtQuick 2.12
import bsh.backend 1.0

FlickerScreen {
    id: root
    property string title
    property GenericListModel listModel

    initialFooterBottomMargin: -25
    footerPushFadeInTime: pushFadeInTime
    contentExitScale: 1.2
    contentEntryScale: 0.8

    header: Header {
        hasBackButton: true
        runBackArrowAnimation: true
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
            model: listModel
            delegate: ProgramTileButton {
                programDefinition: (index >= 0) ? listModel.get(index) : null
                backgroundSource: blurredBackground
                backgroundRelativeX: -flickableItem.contentX + contentContainer.x + flickableItem.x
                backgroundRelativeY: contentContainer.y + flickableItem.y
                onClicked: {
                    if (programDefinition.bgImage) {
                        backend.setCurrentProgramFromDefinition(programDefinition)
                        if (programDefinition.isCleaningProgram) display.push("MealConfigScreen.qml")
                        else display.push("ProgramConfigScreen.qml")
                    }
                }
            }
        }
    }


    footer: Footer {
        backgroundSource: blurredBackground
        hasInfoButton: false
    }
}
