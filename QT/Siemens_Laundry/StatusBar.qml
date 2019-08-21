import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: statusBar
    width: 1280 //parent.width
    height: 554/7 //parent.height/5
//    border.width: 1
//    border.color: "black"
    signal backbtn_clicked

    property int iconWidth: 80
    property int iconHeight: 50
    property string sysTime: "12:31"
    property string modeName: ""
    property string backButtonText: ""
    property int modeNameFontSize: 40
    property int sysTimeFontSize: 35

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: backButton
            height: parent.height
            width: 100
            clip: true
//            border.color: "black"
//            border.width: 1

            Text {
                id: backButtonName
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 40
                text: backButtonText
                //stackView.depth > 1 ? "\u25C0" : "\u2630"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    statusBar.backbtn_clicked()
                }
            }
        }

        Rectangle {
            width: parent.width - backButton.width
            height: parent.height
//            border.color: "black"
//            border.width: 1

            RowLayout {
                anchors.fill: parent
                spacing: 2
                layoutDirection: Qt.RightToLeft

                Rectangle {
                    width: iconWidth
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Image {
                        id: setting
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "res/icon/setting-icon.png"
                    }
                }

                Rectangle {
                    width: iconWidth*1.5
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Text {
                        id: globalTime
                        width: parent.width
                        height: parent.height
                        font.pointSize: sysTimeFontSize
                        text: sysTime
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Rectangle {
                    width: iconWidth
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Image {
                        id: wifi
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "res/icon/wifi-icon.png"
                    }
                }

                Rectangle {
                    width: iconWidth
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Image {
                        id: blueTooth
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "res/icon/bluetooch-icon.png"
                    }
                }

                Rectangle {
                    width: iconWidth
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Image {
                        id: charging
                        width: parent.width
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "res/icon/charging-icon.png"
                    }
                }

                Rectangle {
                    width: iconWidth*4
                    height: iconHeight
//                    border.color: "black"
//                    border.width: 1
                    Layout.alignment: Qt.AlignLeft
                    clip: true

                    Text {
                        id: currentMode
                        width: parent.width
                        height: parent.height
                        font.pointSize: modeNameFontSize
                        text: modeName
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Item {
                    Layout.fillWidth: true
                }
            }
        }
    }
}


//    Image {
//        id: wifi
//        x: 954
//        y: 5
//        height: statusBar.height-10
//        width: height
//        anchors.right: parent.right
//        fillMode: Image.PreserveAspectFit
//        source: "res/icon/wifi-icon.png"
//        anchors.rightMargin: 257
//        clip: false
//    }

//    Image {
//        id: bluetooth
//        x: 879
//        y: 5
//        height: statusBar.height-10
//        width: height
//        anchors.right: parent.right
//        fillMode: Image.PreserveAspectFit
//        source: "res/icon/bluetooch-icon.png"
//        anchors.rightMargin: 332
//        clip: false
//    }

//    Image {
//        id: charging
//        x: 804
//        y: 5
//        height: statusBar.height-10
//        width: height
//        anchors.right: parent.right
//        fillMode: Image.PreserveAspectFit
//        source: "res/icon/charging-icon.png"
//        anchors.rightMargin: 407
//        clip: false
//    }

//    Label {
//        id: time
//        x: 1029
//        y: 8
//        width: 168
//        height: statusBar.height-10
//        text: qsTr("12:30")
//        anchors.verticalCenterOffset: 0
//        horizontalAlignment: Text.AlignHCenter
//        verticalAlignment: Text.AlignVCenter
//        font.pointSize: 40
//        anchors.verticalCenter: parent.verticalCenter
//    }
