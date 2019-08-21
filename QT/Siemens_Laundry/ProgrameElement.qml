import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: element
    signal clicked
    property alias color: theElement.color
    property string title: "default"
    property string imgUrl: "res/icon/Washing-img.png"
    property string description: ""
    property int itemWidth: 1280/3-35
    property int itemHeight: 554 - 554/6 -20
    property int xOffset: 20
    property int titleSize: 40
    property int descSize: 25

    Rectangle {
        id: theElement
        border.width: 1
        border.color: "black"
        radius: 8
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "white" }
//            GradientStop { position: 1.0; color: "light grey" }
//        }

        Column {
            width: parent.width
            height: parent.height/3
            anchors.centerIn: parent
            spacing: 20

            Text {
                text: title
                font.pointSize: titleSize
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Text {
                text: description
                font.pointSize: descSize
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        Rectangle {
            id: theRect
            width: parent.width-20
            height: parent.height/3-10
            y: height*2
            x: 10
//            border.width: 1
//            border.color: "black"

            Image {
                source: imgUrl
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }
        }

        x: xOffset
        width: itemWidth
        height: itemHeight

//        MouseArea {
//            id: area
//            width: parent.width
//            height: parent.height
//            onClicked: theRect.visible = !theRect.visible
//        }
        MouseArea {
            anchors.fill: parent
            onClicked: element.clicked()
        }
    }
}

