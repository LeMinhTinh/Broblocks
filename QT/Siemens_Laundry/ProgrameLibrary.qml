import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2

Window {
    id: mainWindow
    visible: true
    /*Application width and height should be takend from device configuration*/
    width: 1280
    height: 544
    title: qsTr("Seimens Laundry")

//    Dialog {
//        visible: true
//        title: "Blue sky dialog"

//        contentItem: Rectangle {
//            color: "lightskyblue"
//            implicitWidth: 400
//            implicitHeight: 100
//            Text {
//                text: "Hello blue sky!"
//                color: "navy"
//                anchors.centerIn: parent
//            }
//        }
//    }
    Button{
        text: "click me"
        onClicked: popup.open()
    }

    Popup {
        id: popup
        width: 800
        height: parent.height
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }
}
