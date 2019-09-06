import QtQuick 2.12

MouseArea {
    id: root
    property real backgroundRelativeX
    property real backgroundRelativeY
    property Item backgroundSource
    property bool isLongPressed: false

    property bool embedded: false
    property bool hasShadow: false
    property bool hasShine: false

    Loader {
        anchors.fill: parent
        active: backgroundSource
        sourceComponent: ShaderEffectSource {
            sourceRect: Qt.rect(root.backgroundRelativeX + root.x, root.backgroundRelativeY + root.y, root.width, root.height)
            sourceItem: root.backgroundSource

            Rectangle {
                anchors.fill: parent
                color: themedLightContrastColor
                opacity: 0.08
            }
        }
    }

    Timer {
        id: longPressTimer
        interval: 150
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

        opacity: 0.08
        z: 1
        visible: !embedded && isLongPressed
        color: "#ffffff"
    }

    TileShadow { visible: hasShadow && !embedded }
    TileShine { visible: hasShine && !embedded }
}
