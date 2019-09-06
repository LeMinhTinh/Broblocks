import QtQuick 2.12

MouseArea {
    id: root

    readonly property real defaultKeyWidth: 101
    readonly property real defaultKeyHeight: 76
    property string text: ""
    property string iconSource: ""
    property color contentColor: "#ffffff"

    width: defaultKeyWidth
    height: defaultKeyHeight
    opacity: pressed ? 0.8 : 1.0

    Rectangle {
        anchors.fill: parent
        color: themedStrongContrastColor
        opacity: 0.15
    }

    Text {
        visible: root.text
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: 0.5 * root.height
        color: root.contentColor
    }

    Icon {
        visible: root.iconSource
        anchors.centerIn: parent
        source: root.iconSource
        color: root.contentColor
    }
}
