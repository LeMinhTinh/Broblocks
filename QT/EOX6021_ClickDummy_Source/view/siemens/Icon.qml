import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    property string source
    property color color

    Image {
        id: image
        source: root.source
        visible: false
        anchors.fill: parent
    }
    ColorOverlay {
        anchors.fill: image
        source: image
        cached: true
        color: root.color
    }

    implicitWidth: image.implicitWidth
    implicitHeight: image.implicitHeight
}
