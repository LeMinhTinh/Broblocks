import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../common"
import "../dummy"


Rectangle{
    id: modeWindow
    anchors.fill: parent

    signal pageChangeTo(string pageName)
    signal modeSelected(int index)

//    Column {
//        anchors.fill: parent
//        spacing: 5

//        /*Status bar*/
//        StatusBar {
//            id: siemenStatusBar
//            backButtonText: ""
//        }

        /*Mode selection list*/
        Rectangle {
            id: modebar
            width: 1280 - x //parent.width
            height: 554 - 554/6 //parent.height/5
            x: 20
            y: parent.height - height
            border.width: 0.1
            border.color: "black"

            /*Loading list of program mode from model*/

            Component {
                id: myDelegateComponent

                ProgramElement {
                    imgUrl: url
                    title: name
                    itemWidth: 405
                    itemHeight: 422

                    onClicked: {
                        console.log("Mode element clicked " + index)
                        /*Sellect mode index and load corresponse program list*/
                        modeSelected(index)
                        pageChangeTo("screen/Scr_ProgramSelection.qml")
                    }
                }
            }

            ListView {
                anchors.fill: parent
                orientation: ListView.Horizontal
                spacing: 10
                model: DummyModeModel{}
                delegate: myDelegateComponent
            }
        }

//    }
}
