import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {
    property string source
    property color color

    Image {
        id: image
        source: parent.source
        visible: false
        anchors.fill: parent
    }
    ColorOverlay {
        anchors.fill: image
        source: image
        cached: true
        color: parent.color
    }

    implicitWidth: image.implicitWidth
    implicitHeight: image.implicitHeight
}
