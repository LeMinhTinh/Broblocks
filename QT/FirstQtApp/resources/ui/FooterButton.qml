import QtQuick 2.11

MouseArea {
    id: root
    property color fontColor: "#ffffff"
    property real fontPixelSize: constants.homeTileTextSize
    property color color: constants.defaultBlue
    property string text
    property real borderWidth: 0
    property color borderColor: fontColor
    property int textRotationTime: 250

    property Animation fadeOutText: ParallelAnimation {
        NumberAnimation {
            target: buttonLabel
            properties: "opacity"
            from: 1
            to: 0
            duration: textRotationTime
            easing.type: Easing.Linear
        }
        NumberAnimation {
            target: buttonLabel
            properties: "fontPixelSize"
            from: root.fontPixelSize
            to: 0.7 * fontPixelSize
            duration: textRotationTime
            easing.type: Easing.Linear
        }
        NumberAnimation {
            target: buttonLabel
            properties: "anchors.verticalCenterOffset"
            from: 0
            to: -30
            duration: textRotationTime
            easing.type: Easing.Linear
        }
    }

    property Animation fadeInText: ParallelAnimation {
        NumberAnimation {
            target: buttonLabel
            properties: "opacity"
            from: 0
            to: 1
            duration: textRotationTime
            easing.type: Easing.Linear
        }
        NumberAnimation {
            target: buttonLabel
            properties: "fontPixelSize"
            from: 0.7 * root.fontPixelSize
            to: fontPixelSize
            duration: textRotationTime
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            target: buttonLabel
            properties: "anchors.verticalCenterOffset"
            from: 30
            to: 0
            duration: textRotationTime
            easing.type: Easing.Linear
        }
    }

    implicitWidth: 298
    implicitHeight: 96

    Rectangle {
        anchors.fill: parent

        color: parent.color
        border.width: borderWidth
        border.color: borderColor
    }

    TextLabel {
        id: buttonLabel
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: parent.fontPixelSize
        color: parent.fontColor
        text: parent.text
        opacity: 1
    }

    Rectangle {
        id: highlightingOverlay
        anchors.fill: parent

        opacity: 0.1
        visible: false
        color: "#ffffff"
    }

    pressAndHoldInterval: 70
    onPressAndHold: state = "enabled"
    onReleased: {
        // Workaround for clicked not being emmited after pressAndHold
        if (state == "enabled") clicked(mouse)
        state = ""
    }
    onContainsMouseChanged: state = ""
    onCanceled: state = ""
    states: [
        State {
            name: "enabled"
            PropertyChanges {
                target: highlightingOverlay
                visible: true
            }
            PropertyChanges {
                target: buttonLabel
                opacity: 0.7
            }
        }
    ]
}
