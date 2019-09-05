import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "../common"
import "../dummy"


Rectangle{
    id: templateWindow
    anchors.fill: parent
    signal pageChangeTo(string pageName)
    signal programSelected(int index)

    Rectangle {
        id: template
        width: 1280 - x
        height: 554 - 554/6
        x: 20
        y: parent.height - height
        clip: true

        border.color: "black"
        border.width: 1

        /************************************/
        //Put your code here

        Button{
            text: "hello"
        }
    }
}
