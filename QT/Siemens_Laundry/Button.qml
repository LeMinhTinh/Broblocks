import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

// Note that if we use with Item{} we will have more control on our Object and export minimum API
Rectangle {
    id: root
    // export button properties
    property alias text: label.text
    signal clicked

    width: 116; height: 26
    color: "lightsteelblue"
    border.color: "slategrey"

    Text {
        id: label
        anchors.centerIn: parent
        text: "Start"
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.clicked()
        }
    }
}

//Button { // our Button component
//    id: button
//    x: 12; y: 12
//    text: "Start"
//    onClicked: {
//        status.text = "Button clicked!"
//    }
//}

//Text { // text changes when button was clicked
//    id: status
//    x: 12; y: 76
//    width: 116; height: 26
//    text: "waiting ..."
//    horizontalAlignment: Text.AlignHCenter
//}
