import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileStringSlider {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    function setProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.isInAlternativeMode != manualChecked) programOption.isInAlternativeMode = manualChecked
        if(programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    }

    visible: programDefinition.steam
    programOption: programDefinition.steam
    isOptionDeactivated: programOption.isDeactivated
    manualChecked: programOption.isInAlternativeMode
    optionIndex: programOption.currentIndex
    optionUnit: ""
    optionName: "addition of steam"
    optionIcon: "file:resources/icons/steam.png"

    hasManualOption: true
}
