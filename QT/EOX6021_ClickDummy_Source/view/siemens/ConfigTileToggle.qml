import QtQuick 2.12
import bsh.backend 1.0

ConfigTile {
    id:root

    property ProgramBooleanOption programOption
    property bool updateProgramOptionOnChange: true

    property string currentValue: "aus"
    property bool optionEnabled: programOption.isEnabled

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: optionEnabled ? "ein" : "aus"
        iconSource: root.optionIcon
        isDeactivated: root.isOptionDeactivated
        isEnabled: optionEnabled
    }

    onClicked: if(updateProgramOptionOnChange) programOption.isEnabled = !programOption.isEnabled
}
