import QtQuick 2.12
import QtQuick.Controls 2.12

MouseArea {
    id: root
    property string iconSource
    property string title
    property bool isLongPressed: false
    opacity: animationProgress
    width: parent.width
    height: animationProgress * 96

    Icon {
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 40
        anchors.verticalCenter: parent.verticalCenter
        source: root.iconSource
        color: themedStrongContrastColor
    }
    TextLabel {
        anchors.left: parent.left
        anchors.leftMargin: root.iconSource ? 86 : 27
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.textSizeF1
        color: themedStrongContrastColor
        text: root.title
    }

    Timer {
        id: longPressTimer
        interval: 90
        onTriggered: isLongPressed = true
    }
    onPressedChanged: {
        if ( pressed ) {
            longPressTimer.restart()
        } else {
            longPressTimer.stop()
            isLongPressed = false
        }
    }
    Rectangle {
        anchors.fill: parent
        opacity: 0.08
        z: 1
        visible: isLongPressed
        color: "#ffffff"
    }
}
