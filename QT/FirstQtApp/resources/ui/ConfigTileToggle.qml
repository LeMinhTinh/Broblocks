import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTile {
    id:root

    property ProgramBooleanOption programOption
    property bool updateProgramOptionOnChange: true

    property string currentValue: "off"
    property bool optionEnabled: programOption.isEnabled

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: optionEnabled ? "on" : "off"
        iconSource: root.optionIcon
        isDeactivated: root.isOptionDeactivated
        isEnabled: optionEnabled
    }

    onClicked: if(updateProgramOptionOnChange) programOption.isEnabled = !programOption.isEnabled
}
