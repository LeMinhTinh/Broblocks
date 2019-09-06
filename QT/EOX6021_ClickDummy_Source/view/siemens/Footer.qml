import QtQuick 2.12
import bsh.backend 1.0

Item {
    id: root
    property Item backgroundSource
    property string actionButtonText: ""
    property string cancelButtonText: ""
    property alias infoButton: infoButton
    property alias infoBubble: infoBubble
    property alias actionButton: actionButton
    property bool hasInfoButton: true

    signal action()
    signal cancel()

    height: 96

    // Footer Blur
    ShaderEffectSource {
        visible: backgroundSource
        anchors.fill: parent
        sourceRect: Qt.rect(parent.x, parent.y, width, height)
        sourceItem: backgroundSource

        Rectangle {
            anchors.fill: parent
            color: themedLightContrastColor
            opacity: 0.08
        }
    }

    IconButton {
        id: infoButton
        anchors.bottom: parent.bottom
        width: 96
        height: 96
        source: "file:resources/siemens/icons/icn_info.png"
        color: themedStrongContrastColor
        visible: hasInfoButton
    }

    DynamicInfoBubble {
        id: infoBubble
        tipX: infoButton.x + 0.5 * infoButton.width
        tipY: infoButton.y + 10
    }

    FooterButton {
        id: cancelButton
        width: 298
        height: 96
        fontPixelSize: constants.textSizeF4
        anchors.bottom: parent.bottom
        anchors.right: actionButton.left
        visible: (cancelButtonText != "")
        text: cancelButtonText
        color: "#20ffffff"
        onClicked: cancel()
        pressAndHoldInterval: 0
    }

    FooterButton {
        id: actionButton
        width: 298
        height: 96
        fontPixelSize: constants.textSizeF4
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        visible: (actionButtonText != "")
        text: actionButtonText
        onClicked: action()
        pressAndHoldInterval: 0
    }

    TileShine {}
}
