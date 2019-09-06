import QtQuick 2.11
import bsh.eox6021 1.0

Item {
    id: root
    property Item backgroundSource
    property string actionButtonText: ""
    property string cancelButtonText: ""
    property alias infoButton: infoButton
    property alias infoBubble: infoBubble
    property alias actionButton: actionButton

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
        anchors.verticalCenter: parent.verticalCenter
        anchors.leftMargin: 20
        anchors.left: parent.left
        height: parent.height*0.7
        width:height
        source: "file:resources/icons/icn_info.png"
        color: themedStrongContrastColor
    }

    DynamicInfoBubble {
        id: infoBubble
        tipX: infoButton.x + 0.5 * infoButton.width
        tipY: infoButton.y + 10
    }

    FooterButton {
        id: cancelButton
        anchors.bottom: parent.bottom
        anchors.right: actionButton.left
        visible: (cancelButtonText != "")
        text: cancelButtonText
        color: "#20000000"
        onClicked: cancel()
        pressAndHoldInterval: 0
    }

    FooterButton {
        id: actionButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        visible: (actionButtonText != "")
        text: actionButtonText
        onClicked: action()
        pressAndHoldInterval: 0
    }

    TileShine {}
}
