import QtQuick 2.11

//锁屏界面
BaseScreen
{
    //    content挂在在这个外层对象之下
    content: Item {
        TextLabel {
            anchors.centerIn: parent
            //            text: getHhMmFromSeconds(backend.wallClock)
            text:clickDummy.date.getHours()+':'+date.getMinutes()+':'+date.getSeconds()
            fontPixelSize: constants.standbyScreenTextSize
            color: themedStrongContrastColor
        }

        TextLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            y: 460 - height
            color: themedStrongContrastColor
            text: date.getFullYear() + '/' +date.getMonth() + '/' + date.getDate() +' ' +['Sun','Mon','Tue','Wed','Thu','Fri','Sat'][date.getDay()]//'   Week:'+date.getDay()
            fontPixelSize: 45
        }
    }

    //    点击后调用电源按钮
    MouseArea{
        anchors.fill: parent
        onClicked: {
            onOffButton.state = (onOffButton.state === "enabled") ? "" : "enabled"
        }
    }
}
