import QtQuick 2.11

MouseArea {
    property real backgroundRelativeX
    property real backgroundRelativeY
    property Item backgroundSource
    property bool isLongPressed: false

    property bool embedded: false

    ShaderEffectSource {
        visible: backgroundSource
        anchors.fill: parent
        sourceRect: Qt.rect(parent.backgroundRelativeX + parent.x, parent.backgroundRelativeY + parent.y, parent.width, parent.height)
        sourceItem: backgroundSource

        Rectangle {
            anchors.fill: parent
            color: themedLightContrastColor
            opacity: 0.08
        }
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
        id: highlightingOverlay
        anchors.fill: parent

        opacity: 0.1
        z: 1
        visible: !embedded && !preventStealing && isLongPressed
        color: "#ffffff"
    }

    TileShadow { visible: !embedded }
}
