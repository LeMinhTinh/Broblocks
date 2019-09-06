import QtQuick 2.12
import QtQuick.Shapes 1.12

Loader {
    id: root
    property real strokeWidth: approximateInNativeResolution(2)
    property bool useSolidLine: false
    property color color: constants.settingsInactiveColor
    anchors.fill: parent
    active: visible
    sourceComponent: Shape {
        vendorExtensionsEnabled : false
        anchors.fill: parent
        ShapePath {
            strokeColor: color
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            strokeStyle: ShapePath.DashLine
            dashPattern: useSolidLine ? [1, 0] : [6, 3]

            startX: root.strokeWidth
            startY: root.strokeWidth
            PathLine { x: width - root.strokeWidth; y: root.strokeWidth }
        }
        ShapePath {
            strokeColor: color
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            strokeStyle: ShapePath.DashLine
            dashPattern: useSolidLine ? [1, 0] : [6, 3]

            startX: root.strokeWidth
            startY: root.strokeWidth
            PathLine { x: root.strokeWidth; y: height - root.strokeWidth }
        }
        ShapePath {
            strokeColor: color
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            strokeStyle: ShapePath.DashLine
            dashPattern: useSolidLine ? [1, 0] : [6, 3]

            startX: width - root.strokeWidth
            startY: root.strokeWidth
            PathLine { x: width - root.strokeWidth; y: height - root.strokeWidth }
        }
        ShapePath {
            strokeColor: color
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            strokeStyle: ShapePath.DashLine
            dashPattern: useSolidLine ? [1, 0] : [6, 3]

            startX: root.strokeWidth
            startY: height - root.strokeWidth
            PathLine { x: width - root.strokeWidth; y: height - root.strokeWidth }
        }
    }
}
