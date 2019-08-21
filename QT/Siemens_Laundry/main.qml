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

//    background: Rectangle {
//        color: "#FFFFEF"
//        gradient: Gradient {
//            GradientStop { position: 0.0; color: "white" }
//            GradientStop { position: 1.0; color: "light grey" }
//        }
//    }
    Column {
        anchors.fill: parent


        StatusBar {
            id: siemenStatusBar
//            anchors {
//                left: parent.left
//                top: parent.top
//            }
            backButtonText: stackView.depth > 1 ? "\u25C0" : ""

            onBackbtn_clicked: {
                if (stackView.depth > 1){
                    stackView.pop()
                }
                else{
                    stackView.push("ProgrameSubList.qml")
                }
            }
        }


        StackView {
            id: stackView
            width: 1280
            height: 554 - 554/6
            initialItem: "ProgrameList.qml"
        }
    }
}
