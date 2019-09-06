import QtQuick 2.11
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

//runningscreen中的状态信息

MouseArea {
    id: root
    property string iconSource
    property color iconColor : valueColor
    property string value
    property color valueColor
    property string unit: ""
    property int fontPixelSize: constants.smallTitleSize
    property real iconMargin: 20
    property bool seperatorVisible: true
    property bool unitOnTop: false
    property bool isEnabled
    property bool isDeactivated: true
    property bool firstLabel: false
    property bool lastLabel: false
    property bool hasProgressBar: false
    property real progress

    implicitWidth: childrenRect.width
    implicitHeight: Math.max(icon.height, valueLabel.height)
    visible: width != 0

    states: [
        State {
            name: "disabled"
            PropertyChanges { target: root; width: 0}
            PropertyChanges { target: root; opacity: 0}
        }
    ]

    transitions: [
        Transition {
            to: "disabled"
            animations: ParallelAnimation {
                NumberAnimation {
                    target: root
                    properties: "opacity"
                    to: 0
                    duration: 300
                    easing.type: Easing.Linear
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 150
                    }
                    NumberAnimation {
                        target: root
                        properties: "width"
                        to: 0
                        duration: 750
                        easing.type: Easing.OutCubic
                    }
                }
            }
        },
        Transition {
            to: ""
            animations: ParallelAnimation {
                NumberAnimation {
                    target: root
                    properties: "width"
                    to: implicitWidth
                    duration: 750
                    easing.type: Easing.OutCubic
                }
                SequentialAnimation {
                    PauseAnimation {
                        duration: 600
                    }
                    NumberAnimation {
                        target: root
                        properties: "opacity"
                        to: 1
                        duration: 300
                        easing.type: Easing.Linear
                    }
                }
            }
        }
    ]

    Item {
        id: leftMargin
        width: 40
        visible: !firstLabel
    }
    Icon {
        id: icon
        anchors.left: firstLabel ? parent.left : leftMargin.right
        anchors.verticalCenter: parent.verticalCenter
        source: iconSource
        color: isEnabled ? constants.defaultBlue : isDeactivated ? constants.inactiveColor : iconColor
    }
    TextLabel {
        id: valueLabel
        anchors.left: icon.right
        anchors.leftMargin: iconMargin
        anchors.verticalCenter: icon.verticalCenter
        fontPixelSize: root.fontPixelSize
        color: isDeactivated ? constants.inactiveColor : valueColor
        text: value
    }
    TextLabel {
        id: unitLabel
        anchors.left: valueLabel.right
        anchors.bottom: !unitOnTop ? valueLabel.bottom : undefined
        anchors.top: unitOnTop ? valueLabel.top : undefined
        fontPixelSize: 0.5 * valueLabel.fontPixelSize
        color: isDeactivated ? constants.inactiveColor : valueColor
        text: unit
    }
    ProgressBar {
        id: progressBar
        anchors.top: valueLabel.bottom
        anchors.topMargin: 15
        anchors.left: valueLabel.left
        anchors.right: unitLabel.right
        width: temperature.width
        value: progress
        background: Rectangle {
            color: "#999999"
            opacity: 0.6
        }
        height: 3
        visible: hasProgressBar
        contentItem: Item {
            Rectangle {
                width: progressBar.visualPosition * parent.width
                height: parent.height
                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(parent.width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#006fd3" }
                        GradientStop { position: 1.0 / progressBar.visualPosition; color: "#28bbff" }
                    }
                }
            }
        }
    }
    Image {
        id: seperator
        source: "file:resources/icons/separator.png"
        width: 2.5
        visible: !lastLabel
        anchors.verticalCenter: icon.verticalCenter
        anchors.left: valueLabel.right
        anchors.leftMargin: 40 + unitLabel.width
    }
}
