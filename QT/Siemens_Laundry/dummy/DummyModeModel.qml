import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ListModel {
    id: myModel
//        property int elementWidth: 391//1280/3-35
//        property int elementHeight: 442//554 - 554/6 -20
    ListElement{name: "Wash"; url: "../res/icon/Washing-img.png"}
    ListElement{name: "Wash & Dry"; url: "../res/icon/washing-drying-img.png"}
    ListElement{name: "Dry"; url: "../res/icon/Dry-img.png"}
}

