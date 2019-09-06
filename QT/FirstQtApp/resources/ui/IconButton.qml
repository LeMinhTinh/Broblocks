import QtQuick 2.11
import QtGraphicalEffects 1.0

MouseArea {
    id: root
    property string source
    property color color
    property real iconWidth
    property real iconHeight

    Icon {
        id: icon
        source: parent.source
        color: parent.color
        opacity: parent.pressed ? 0.7 : 1
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width|| implicitWidth
        height: parent.height || implicitHeight
    }

    implicitWidth: icon.implicitWidth
    implicitHeight: icon.implicitHeight
}
