import QtQuick 2.12
import bsh.backend 1.0

ConfigTileWheel {
    id: optionWheel

    property ProgramIntegerMappingOption programOption
    property bool updateProgramOptionOnChange: true

    // propagate down
    options: programOption.options
    optionIndex: programOption.currentIndex
    optionEnabled: programOption.isEnabled
    // propagate up
    function updateProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    }
    onCurrentIndexChanged: if(updateProgramOptionOnChange) updateProgram()
    onCurrentEnabledChanged: if(updateProgramOptionOnChange) updateProgram()
}
