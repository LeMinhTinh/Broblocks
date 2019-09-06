import QtQuick 2.11
import QtQuick.Shapes 1.11

Shape {
    id: root
    vendorExtensionsEnabled : false
    property real strokeWidth: 3.0
    property bool useSolidLine: false
    property color color: constants.inactiveColor
    anchors.fill: parent
    ShapePath {
        strokeColor: color
        strokeWidth: root.strokeWidth
        fillColor: "transparent"
        strokeStyle: ShapePath.DashLine
        dashPattern: useSolidLine ? [1, 0] : [4, 4]

        startX: 0
        startY: 0
        PathLine { x: width; y: 0 }
        PathLine { x: width; y: height }
        PathLine { x: 0; y: height }
        PathLine { x: 0; y: 0 }
    }
}
