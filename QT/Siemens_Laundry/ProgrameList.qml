import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

import Laundry 1.0

Rectangle {
    id: programbar
    width: 1280 //parent.width
    height: 554 - 554/6 //parent.height/5
    x: 0
    y: parent.height - height
    border.width: 0.1
    border.color: "black"
    focus: true

    ListModel {
        id: myModel
//        property int elementWidth: 391//1280/3-35
//        property int elementHeight: 442//554 - 554/6 -20
        ListElement{name: "Wash"; url: "res/icon/Washing-img.png"}
        ListElement{name: "Wash & Dry"; url: "res/icon/washing-drying-img.png"}
        ListElement{name: "Dry"; url: "res/icon/Dry-img.png"}
    }

    Component {
        id: myDelegateComponent

        ProgrameElement {
            imgUrl: url
            title: name
            itemWidth: 400
            itemHeight: 442

            onClicked: {
//                console.log("element clicked")
//                ld.source="ProgrameSubList.qml"

            }
        }

    }

    ListView {
        implicitWidth: parent.width
        implicitHeight: parent.height
        orientation: Qt.Horizontal
        spacing: 415

        model: myModel
        delegate: myDelegateComponent
    }

//    MouseArea {
//        anchors.fill: parent
//        onClicked: {
//            ld.source="ProgrameSubList.qml"
//        }
//    }

    Loader{
        id:ld
        anchors.fill: parent
    }
}
