import QtQuick 2.12
import bsh.backend 1.0

ConfigTileStringSlider {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    visible: programDefinition.steam
    programOption: programDefinition.steam
    isOptionDeactivated: programOption.isDeactivated
    manualChecked: programOption.isInAlternativeMode
    optionIndex: programOption.currentIndex
    optionUnit: ""
    optionName: "Dampfzugabe"
    optionIcon: "file:resources/siemens/icons/icn_dampfzugabe_running.png"

    hasManualOption: true
}
