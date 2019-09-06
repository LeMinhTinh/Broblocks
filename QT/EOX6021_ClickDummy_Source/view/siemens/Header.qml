import QtQuick 2.12

Item {
    id: root
    property string title: ""
    property bool hasBackButton: false
    property var backHandler: function() { display.pop() }
    property bool hasEditButton: false
    property var editHandler: function() {}
    property color editColor: themedStrongContrastColor
    property bool hasSaveButton: false
    property var saveHandler: function() {}
    property color saveColor: themedStrongContrastColor
    property bool runBackArrowAnimation: false
    property real verticalCenterOffset: -2
    property bool showSettingsIcon: false

    property Animation backArrowAnimation: SequentialAnimation {
        running: runBackArrowAnimation
        PropertyAction {
            targets: [backButton, titleElement]
            property: "opacity"
            value: 0
        }
        ParallelAnimation {
            NumberAnimation {
                target: backButton
                property: "x"
                from: 311
                to: 0
                duration: 500
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: backButton
                property: "opacity"
                to: 1
                duration: 500
                easing.type: Easing.InCubic
            }
            SequentialAnimation {
                PauseAnimation {
                    duration: 300
                }
                NumberAnimation {
                    target: titleElement
                    property: "opacity"
                    to: 1
                    duration: 200
                    easing.type: Easing.Linear
                }
            }
        }
    }

    height: 96

    IconButton {
        id: backButton
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.verticalCenterOffset
        width: 94
        height: 94
        visible: hasBackButton
        source: "file:resources/siemens/icons/icn_back.png"
        color: themedStrongContrastColor
        onClicked: backHandler()
    }

    Row {
        id: titleElement
        anchors.left: backButton.right
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: root.verticalCenterOffset
        spacing: 25
        Image {
            visible: title && hasBackButton
            anchors.verticalCenter: parent.verticalCenter
            source: "file:resources/siemens/icons/separator1P.png"
            width: approximateInNativeResolution(1)
        }
        TextLabel {
            id: titleLabel
            anchors.verticalCenter: parent.verticalCenter
            fontPixelSize: constants.textSizeF4
            color: themedLightContrastColor
            text: title
            horizontalAlignment: Text.AlignHCenter
        }
        IconButton {
            id: editButton
            visible: hasEditButton
            anchors.bottom: titleLabel.bottom
            source: "file:resources/siemens/icons/icn_edit.png"
            color: editColor
            onClicked: editHandler()
            touchWidth: 86
            touchHeight: 86
        }
        MouseArea {
            id: saveButton
            visible: hasSaveButton
            anchors.bottom: titleLabel.bottom
            width: saveLabel.width
            height: saveLabel.height
            onClicked: saveHandler()
            TextLabel {
                id: saveLabel
                text: "Speichern"
                color: saveColor
                fontPixelSize: constants.textSizeF4
            }
        }
    }

    Icon {
        id: homeconnectIcon
        source: "file:resources/siemens/icons/icn_homeconnect_header.png"
        anchors.right: wlanIcon.left
        anchors.rightMargin: 24
        anchors.bottom: wlanIcon.bottom
        color: themedLightContrastColor
    }

    Icon {
        id: wlanIcon
        source: "file:resources/siemens/icons/1_icn_wlan.png"
        anchors.right: clockLabel.left
        anchors.rightMargin: 27
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.verticalCenterOffset
        color: themedLightContrastColor
    }

    TextLabel {
        id: clockLabel
        anchors.right: showSettingsIcon ? settingsButton.left : parent.right
        anchors.rightMargin: showSettingsIcon ? 0 : 25
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.verticalCenterOffset
        text: getHhMmFromSeconds(backend.wallClock)
        fontPixelSize: constants.textSizeF1
        color: themedLightContrastColor
        horizontalAlignment: Text.AlignRight
    }

    property alias settingsButton: settingsButton
    IconButton {
        id: settingsButton
        visible: showSettingsIcon
        anchors.right: parent.right
        width: 94
        height: 94
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.verticalCenterOffset
        source: "file:resources/siemens/icons/icn_settings.png"
        color: themedStrongContrastColor
    }
}
