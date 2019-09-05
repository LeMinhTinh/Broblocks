import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: popupProgramInfo
    width: 1280
    height: 544
    signal closePopup

    Rectangle {
        opacity: 0.8
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
        }
    }

    Rectangle {
        width: 900
        anchors.centerIn: parent
        height: parent.height
        color: "light grey"

        /********************************************************/
        //Writing your code here

        Button {
            text: "Close"
            anchors.centerIn: parent
            onClicked: {
                console.log("Program info close")
                popupProgramInfo.closePopup()
            }
        }
    }

}
