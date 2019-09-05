import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../common"
import "../dummy"


Rectangle{
    id: programWindow
    anchors.fill: parent
    signal pageChangeTo(string pageName)
    signal programSelected(int index)
//    Column {
//        anchors.fill: parent
//        spacing: 5

//        /*Status bar*/
//        StatusBar {
//            id: siemenStatusBar
//            /*Display modeName by mode from model*/
//            modeName: {
//                if (0){
//                    "Wash"
//                }
//                else{
//                    "Wash & Dry"
//                }
//            }
//            backButtonText: "\u25C0"
//            onBackbtn_clicked: {
//                pageChangeTo("Scr_ModeSelection.qml")
//            }
//        }

        /*Program selection list*/
        Rectangle {
            id: programbar
            width: 1280 - x //parent.width
            height: 554 - 554/6 //parent.height/5
            x: 20
            y: parent.height - height
            clip: true
        //    border.width: 0.1
        //    border.color: "black"

            Component {
                id: myDelegateComponent

                ProgramElement {
                    title: name
                    color: col
                    description: desc
                    itemWidth: 250
                    itemHeight: 422//442
                    titleSize: 30
                    descSize:20

                    onClicked: {
                        console.log("Program element clicked " + index)
                        programSelected(index)
//                        pageChangeTo("")
                        if (index == 5){
                            popupLoader.source ="Popup_ProgramLibrary.qml"
                        }
                        else{
                            mainLoader.source ="Scr_Template.qml"
                        }
                    }
                }
            }

            ListView {
                anchors.fill: parent
                orientation: ListView.Horizontal
                spacing: 10

                model: DummyProgramModel{}
                delegate: myDelegateComponent
            }
        }

//    }
}
