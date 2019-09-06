import QtQuick 2.12

// This indirection to an Image is faster for creating lots of small images (e.g. for shadows)
// TODO The reason is no quite clear yet, layouting or compiler optimization due to not exposing certain features maybe?
Item {
    property string source

    Image {
        id: image
        source: parent.source
        anchors.fill: parent
    }

    implicitWidth: image.implicitWidth
    implicitHeight: image.implicitHeight
}
