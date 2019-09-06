import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    id: root
    property string iconSource
    property color iconColor : valueColor
    property string progressValue
    property string value
    property color valueColor
    property string unit: ""
    property real fontPixelSize: constants.smallTitleTextSize
    property real iconMargin: 20
    property real separatorMargin: 34
    property bool hasSeparator: true
    property bool unitOnTop: false
    property bool isEnabled
    property bool isDeactivated: true
    property bool hasProgressBar: false
    property real progress

    signal clicked()

    implicitWidth: childrenRect.width + separatorMargin
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

    Image {
        id: separator
        anchors.left: parent.left
        source: "file:resources/siemens/icons/separator.png"
        width: hasSeparator ? 2 / uiScale : 0
        visible: hasSeparator
        anchors.verticalCenter: parent.verticalCenter
    }
    Icon {
        id: icon
        anchors.left: separator.right
        anchors.leftMargin: hasSeparator ? separatorMargin : 0
        anchors.verticalCenter: parent.verticalCenter
        source: iconSource
        color: isEnabled ? constants.defaultBlue : isDeactivated ? constants.inactiveColor : iconColor
    }

    TextLabel {
        id: progressValueLabel
        anchors.left: icon.right
        anchors.leftMargin: iconMargin
        anchors.verticalCenter: icon.verticalCenter
        fontPixelSize: root.fontPixelSize
        color: isDeactivated ? constants.inactiveColor : valueColor
        text: progressValue
    }
    TextLabel {
        id: progressUnitLabel
        anchors.left: progressValueLabel.right
        anchors.bottom: !unitOnTop ? progressValueLabel.bottom : undefined
        anchors.top: unitOnTop ? progressValueLabel.top : undefined
        fontPixelSize: 0.5 * progressValueLabel.fontPixelSize
        color: isDeactivated ? constants.inactiveColor : valueColor
        text: progressValue ? unit : ""
    }

    TextLabel {
        id: valueLabel
        anchors.left: progressUnitLabel.right
        anchors.verticalCenter: icon.verticalCenter
        fontPixelSize: root.fontPixelSize
        color: isDeactivated ? constants.inactiveColor : valueColor
        text: progressValue ? " / " + value : value
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
        anchors.top: progressValueLabel.bottom
        anchors.topMargin: 15
        anchors.left: progressValueLabel.left
        anchors.right: unitLabel.right
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

    Item {
        anchors.left: icon.left
        anchors.right: unitLabel.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        MouseArea {
            anchors.centerIn: parent
            width: parent.width + 2 * root.separatorMargin
            height: parent.height + 2 * root.separatorMargin
            onClicked: root.clicked()
        }
    }
}
