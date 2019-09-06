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
        title: root.title
        hasBackButton: true
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
                        keyboardOverlay.readText("Mein Favorit", function(newName) {
                            //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                            var programDefinitionCopy = backend.getProgramDefinitionCopy(programDefinition)
                            programDefinitionCopy.origin = programDefinitionCopy
                            programDefinitionCopy.isFavorite = true
                            programDefinitionCopy.name = newName
                            backend.favorites.insert(programDefinitionCopy, 0)
                            backend.setCurrentProgramFromDefinition(programDefinitionCopy)
                            display.push("ProgramConfigScreen.qml")
                        })
                    }
                }
            }
        }
    }

    footer: Footer {
        backgroundSource: blurredBackground
    }
}
