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

    ListModel {
        id: myModel
        ListElement{name: "Cotton"; col: "light grey"; desc: "60, 2h30min"}
        ListElement{name: "Easy Care"; col: "light grey"; desc: "40, 1h30min"}
        ListElement{name: "Mix"; col: "light grey"; desc: "40, 1h45min"}
        ListElement{name: "My Time"; col: "light grey"; desc: "40, 0h30min"}
        ListElement{name: "Jeans"; col: "light grey"; desc: "40, 1h30min"}
    }

    Component {
        id: myDelegateComponent

        ProgrameElement {
            title: name
            color: col
            description: desc
            itemWidth: 250
            itemHeight: 400//442
            titleSize: 30
            descSize:20
        }
    }

    ListView {
        implicitWidth: parent.width
        implicitHeight: parent.height
        orientation: Qt.Horizontal
        spacing: 260

        model: myModel
        delegate: myDelegateComponent
    }


//    MouseArea{
//        anchors.fill: parent;
//        onClicked: ld.source="";
//    }
}
