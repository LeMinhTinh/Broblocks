import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: mainWindow
    visible: true
    /*Application width and height should be takend from device configuration*/
    width: 1280
    height: 544
    title: qsTr("Seimens Laundry")

    Rectangle {
        width: 480
        height: 320
        Rectangle {
            x: 30; y: 30
            width: 300; height: 240
            color: "lightsteelblue"

            MouseArea {
                anchors.fill: parent
                drag.target: parent;
                drag.axis: Drag.XAndYAxis
                drag.minimumX: 30
                drag.maximumX: parent.width
                drag.minimumY: 30
                drag.maximumY: parent.height
                drag.filterChildren: true

                Rectangle {
                    color: "yellow"
                    x: 50; y : 50
                    width: 100; height: 100
                    MouseArea {
                        anchors.fill: parent
                        onClicked: console.log("Clicked")
                    }
                }
            }
        }
    }
}

//Item {
//    width: 500
//    height: 300
//    visible: true

//    ScrollView {
//        width: 200
//        height: 200


//        ListView {
//            model: 20
//            orientation: ListView.Horizontal



//            delegate: ItemDelegate {
//                text: "Item " + index
//            }
//        }
//    }
//}
//    ListView {
//        model: 20
//        spacing: 10
//        //orientation: ListView.Horizontal
//        //ScrollBar.horizontal: ScrollBar{}

//        delegate: ItemDelegate {
//            text: "hello " + index
//        }
//    }

//    ListView{
//        id: listView
//        width: 200
//        height: 200
//        model: 10
//        spacing: 10

//        orientation: ListView.Horizontal
//        //ScrollBar.horizontal: ScrollBar {}

//        delegate: ItemDelegate {
//            Text {
//                text: "Item " + index
//            }
//        }
//    }

//    ScrollView {
//        width: 200
//        height: 200


//        ListView {
//            model: 20
//            delegate: ItemDelegate {
//                text: "Item " + index
//            }
//        }
//    }

//    ScrollView {
//        width: 200
//        height: 200
//        clip: true

//        Label {
//            text: "ABC"
//            font.pixelSize: 224
//        }
//    }

