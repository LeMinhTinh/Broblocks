import QtQuick 2.12

SettingsEntry {
    id: root
    property var value

    TextLabel {
        anchors.right: entryArrow.left
        anchors.rightMargin: 42
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.textSizeF1
        color: constants.settingsInactiveColor
        text: root.value
    }

    Icon {
        id: entryArrow
        anchors.right: root.right
        anchors.rightMargin: 27
        anchors.verticalCenter: root.verticalCenter
        source:  "file:resources/siemens/icons/settings_arrow.png"
        color: themedStrongContrastColor
    }
}
