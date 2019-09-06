//import QtQuick 2.0
import QtQuick.Controls 2.0
//import QtQuick.Window 2.0
//import QtQuick.Layouts 1.11
import QtQuick 2.11
import bsh.eox6021 1.0
BaseScreen
{
    id: settingsPopup
    visible: true
     //width: 200
    // height: 200
     x: 200
     y: 200
     width: Math.min(parent.width, parent.height) / 3 * 2
     height: 400

     //modal: true
     //focus: true
    //title: qsTr("Qml弹出菜单")
    //flags: Qt.FramelessWindowHint


    header: Header {
        hasBackButton: true
        title: qsTr("Setting")
    }

     content:Column{
         anchors.horizontalCenter: parent.horizontalCenter
         anchors.right: parent.right
         anchors.rightMargin: 20

         RadioButton{
             id: enChk
             text: qsTr("English")
             font.pointSize: 26
             checked: true
             onClicked: {
                 //qmlLanguage.setLanguage(0);
                 //display.pop("SettingScreen.qml")
                 trans.selectLanguage("en");
             }
         }
         RadioButton{
             id: cnCHK
             text: qsTr("简体中文")
             font.pointSize: 26
             onClicked: {
                 //qmlLanguage.setLanguage(1);
                 //display.pop("SettingScreen.qml")
             }
         }
        }




}

