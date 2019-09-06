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
        title: root.title
    }

    flickContent: Row {
        height: 424
        id: programList
        spacing: approximateInNativeResolution(6)
        Repeater {
            model: root.model
            delegate: Component {
                ImageTileButton {
                    property NaviagtionMenuItem menuItem: (index >= 0) ? root.model.get(index) : null
                    title: menuItem.name
                    imageSource: menuItem.tileImage
                    onClicked: if(menuItem.targetModel) display.push("MealChoiceScreen.qml", {title: title, backgroundSource: menuItem.bgImage, model: menuItem.targetModel})
                }
            }
        }
    }
}
