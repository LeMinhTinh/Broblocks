import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    anchors.fill: parent
    readonly property real shineWidth: approximateInNativeResolution(1)
    readonly property Gradient shineGradient: Gradient {
        GradientStop { position: 0.0; color: "#20ffffff" }
        GradientStop { position: 0.4; color: "#15ffffff" }
        GradientStop { position: 0.6; color: "#05ffffff" }
        GradientStop { position: 1.0; color: "#00ffffff" }
    }

    LinearGradient {
        id: topBar
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: shineWidth
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: shineGradient
        cached: true
    }
    LinearGradient {
        id: leftBar
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: shineWidth
        start: Qt.point(0, shineWidth)
        end: Qt.point(0, height)
        gradient: shineGradient
        cached: true
    }
}
