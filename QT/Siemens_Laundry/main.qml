import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "common"
import "dummy"
import "screen"

Window {
    id: mainWindow
    visible: true
    /*Application width and height should be takend from device configuration*/
    width: 1280
    height: 544
//    title: qsTr("Seimens Laundry")

    /*Connected signal*/
    //signal pageChangeTo(string pageName)
    Column{
        anchors.fill: parent

        StatusBar{
            id: statusBar
            onBackbtn_clicked: {
                console.log("Back button clicked")
                mainLoader.source="screen/Scr_ModeSelection.qml"
            }
        }

        Loader {
            id: mainLoader
            width: 1280
            height: 554 - 554/7
            source: "screen/Scr_ModeSelection.qml"
        }
    }

    Loader {
        id: popupLoader
        anchors.fill: parent
        source: ""
    }

    Connections {
        target: mainLoader.item
        onPageChangeTo:{
            mainLoader.source = pageName
            statusBar.modeName = "Wash"
            statusBar.backButtonText = "\u25C0"
        }
    }

    Connections {
        target: popupLoader.item
        onClosePopup:{
            popupLoader.source = ""
        }
    }

}

//    StackView {
//        anchors.fill: parent
//        id: stackView
//        initialItem: "Scr_ModeSelection.qml"
//    }

//    Connections{
//        target: stackView.currentItem
//        onPageChangeTo:{
//            stackView.push(pageName)
//        }
//    }
