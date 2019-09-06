import QtQuick 2.12

Item {
    property string message

    TextLabel {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.textSizeF1
        color: themedLightContrastColor
        text: message
        horizontalAlignment: Text.AlignHCenter
        maximumLineCount: 3
    }
}
