import QtQuick 2.12
import bsh.backend 1.0

ConfigTileSlider {
    id: optionSlider

    property ProgramIntegerOption programOption
    property bool updateProgramOptionOnChange: true

    // propagate down
    options: programOption.options
    optionEnabled: programOption.isEnabled
    manualChecked: programOption.isInAlternativeMode
    optionIndex: programOption.currentIndex
    // propagate up
    function updateProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.isInAlternativeMode != manualChecked) programOption.isInAlternativeMode = manualChecked
        if(programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    }
    onCurrentIndexChanged: if(updateProgramOptionOnChange) updateProgram()
    onManualCheckedChanged: if(updateProgramOptionOnChange) updateProgram()
    onCurrentEnabledChanged: if(updateProgramOptionOnChange) updateProgram()
}
