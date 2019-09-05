import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    width: 1280 //parent.width
    height: 554/7 //parent.height/5
//    border.width: 1
//    border.color: "black"
    signal backbtn_clicked

    property int iconWidth: 80
    property int iconHeight: 50
    property string sysTime: Qt.formatTime(new Date(),"hh:mm")
    property string modeName: ""
    property string backButtonText: ""
    property int modeNameFontSize: 40
    property int sysTimeFontSize: 35

    Timer {
        id: timer
        interval: 60000
        repeat: true
        running: true

        onTriggered:
        {
            sysTime = Qt.formatTime(new Date(),"hh:mm")
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 10

        Rectangle {
            id: backButton
            height: parent.height
            width: 100
            clip: true
            radius: 5
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
            width: parent.width - backButton.width - 30
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
                        source: "../res/icon/setting-icon.png"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: popupLoader.source = "../screen/Popup_Setting.qml"
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
                        source: "../res/icon/wifi-icon.png"
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
                        source: "../res/icon/bluetooch-icon.png"
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
                        source: "../res/icon/charging-icon.png"
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
