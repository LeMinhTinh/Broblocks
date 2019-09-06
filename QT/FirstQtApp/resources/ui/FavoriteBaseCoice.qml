import QtQuick 2.11
import bsh.eox6021 1.0

FlickerScreen {
    id: root
    property string title
    property GenericListModel listModel
    centerFlickable: true

    header: Header {
        title: root.title
        hasBackButton: true
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
                        keyboardOverlay.readText("My favorite", function(newName) {
                            //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                            var programCopy = backend.getProgramDefinitionCopy(programDefinition)
                            programCopy.origin = programCopy
                            programCopy.isFavorite = true
                            programCopy.name = newName
                            backend.favorites.insert(programCopy, 0)
                            backend.setCurrentProgramFromDefinition(programCopy)
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
