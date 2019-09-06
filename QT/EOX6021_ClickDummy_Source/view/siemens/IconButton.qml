import QtQuick 2.12

Item {
    id: root
    property string source
    property color color
    property real iconWidth: icon.implicitWidth
    property real iconHeight: icon.implicitHeight
    property real touchWidth: width
    property real touchHeight: height
    property alias touchArea: touchArea
    implicitWidth: iconWidth
    implicitHeight: iconHeight

    signal clicked()

    Icon {
        id: icon
        width: root.iconWidth
        height: root.iconHeight
        source: root.source
        color: root.color
        opacity: touchArea.pressed ? 0.7 : 1
        anchors.centerIn: root
    }

    MouseArea {
        id: touchArea
        width: root.touchWidth
        height: root.touchHeight
        anchors.centerIn: root
        onClicked: root.clicked()
    }
}
