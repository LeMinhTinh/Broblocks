import QtQuick 2.12

Item {
    opacity: animationProgress
    width: parent.width
    height: animationProgress * 160

    property bool soundOff: false
    Icon {
        id: soundIcon
        anchors.horizontalCenter: childlockIcon.horizontalCenter
        anchors.horizontalCenterOffset: -350
        anchors.verticalCenter: childlockIcon.verticalCenter
        source: soundOff ? "file:resources/siemens/icons/settings_sound_off.png" : "file:resources/siemens/icons/settings_sound_on.png"
        color: soundOff ? constants.defaultBlue : themedStrongContrastColor
    }
    TextLabel {
        id: soundLabel
        anchors.horizontalCenter: soundIcon.horizontalCenter
        anchors.top: soundIcon.verticalCenter
        anchors.topMargin: 43
        fontPixelSize: constants.textSizeF1
        color: themedStrongContrastColor
        text: soundOff ? "Ton aus" : "Ton an"
    }
    MouseArea {
        anchors.top: soundIcon.top
        anchors.bottom: soundLabel.bottom
        anchors.left: soundLabel.left
        anchors.right: soundLabel.right
        anchors.margins: -20
        onClicked: soundOff = !soundOff
    }

    property bool childlockActive: false
    Icon {
        id: childlockIcon
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: animationProgress * 89 - 50
        source: "file:resources/siemens/icons/settings_childlock.png"
        color: childlockActive ? constants.defaultBlue : themedStrongContrastColor
    }
    TextLabel {
        id: childlockLabel
        anchors.horizontalCenter: childlockIcon.horizontalCenter
        anchors.top: childlockIcon.verticalCenter
        anchors.topMargin: 43
        fontPixelSize: constants.textSizeF1
        color: themedStrongContrastColor
        text: childlockActive ? "Childlock aktiviert" : "Childlock deaktiviert"
    }
    MouseArea {
        anchors.top: childlockIcon.top
        anchors.bottom: childlockLabel.bottom
        anchors.left: childlockLabel.left
        anchors.right: childlockLabel.right
        anchors.margins: -20
        onClicked: childlockActive = !childlockActive
    }

    property bool lightOff: false
    Icon {
        id: lightIcon
        anchors.horizontalCenter: childlockIcon.horizontalCenter
        anchors.horizontalCenterOffset: 350
        anchors.verticalCenter: childlockIcon.verticalCenter
        source: lightOff ? "file:resources/siemens/icons/settings_lights_off.png" : "file:resources/siemens/icons/settings_light_on.png"
        color: lightOff ? constants.defaultBlue : themedStrongContrastColor
    }
    TextLabel {
        id: lightLabel
        anchors.horizontalCenter: lightIcon.horizontalCenter
        anchors.top: lightIcon.verticalCenter
        anchors.topMargin: 43
        fontPixelSize: constants.textSizeF1
        color: themedStrongContrastColor
        text: lightOff ? "Beleuchtung aus" : "Beleuchtung an"
    }
    MouseArea {
        anchors.top: lightIcon.top
        anchors.bottom: lightLabel.bottom
        anchors.left: lightLabel.left
        anchors.right: lightLabel.right
        anchors.margins: -20
        onClicked: lightOff = !lightOff
    }
}
