import QtQuick 2.12
import bsh.backend 1.0

SettingsEntry {
    id: root
    property ProgramBooleanOption option

    BSHCheckBox {
        id: checkbox
        anchors.right: root.right
        anchors.rightMargin: 20
        anchors.verticalCenter: root.verticalCenter
        label: checked ? "an" : "aus"
        labelColor: constants.settingsInactiveColor
        checked: option ? option.isEnabled : true
        onCheckedChanged: if (option) option.isEnabled = checked
        positionLabelRight: false
        spacing: 42
    }

    onClicked: checkbox.checked = !checkbox.checked
}
