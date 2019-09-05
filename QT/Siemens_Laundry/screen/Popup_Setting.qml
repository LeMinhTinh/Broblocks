import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: popupSetting
    width: 1280
    height: 544
    signal closePopup

    Rectangle {
        anchors.fill: parent
        opacity: 0.8
        MouseArea {
            anchors.fill: parent
        }
    }


    Rectangle {
        id: rectangle
        width: 900
        height: parent.height
        anchors.centerIn: parent
        color: "light grey"

        /********************************************************/
        //Writing your code here

        Text {
            id: name
            x: 403
            text: qsTr("Settings")
            anchors.top: parent.top
            anchors.topMargin: 14
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 20
        }

        Button {
            text: "Close"
            anchors.centerIn: parent
            onClicked: {
                console.log("Setting close")
                popupSetting.closePopup()
            }
        }
    }
}
