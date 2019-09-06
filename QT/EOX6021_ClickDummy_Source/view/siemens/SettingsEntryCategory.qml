import QtQuick 2.12

SettingsEntry {
    id: root
    property var model

    Icon {
        anchors.right: root.right
        anchors.rightMargin: 27
        anchors.verticalCenter: root.verticalCenter
        source:  "file:resources/siemens/icons/settings_arrow.png"
        color: themedStrongContrastColor
    }
    onClicked: if (model) settingsStack.push("SettingsMenu.qml", {"model": model, "title": title})
}
