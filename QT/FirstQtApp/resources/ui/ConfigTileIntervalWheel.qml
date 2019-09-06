import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileWheel {
    id: optionWheel

    property ProgramIntegerIntervalOption programOption
    property bool updateProgramOptionOnChange: true

    function intervalToString(option) {
        var stringList = []
        for(var i=0; i<=option.intervalCount; i++) {
            stringList.push(option.startingValue+i*option.intervalLength.toString())
        }
        return stringList
    }

    function setProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.intervalIndex != currentIndex) programOption.intervalIndex = currentIndex
    }

    options: intervalToString(programOption)
    optionIndex: programOption.intervalIndex
    optionEnabled: programOption.isEnabled

    Connections {
        target: programOption
        onIsEnabledChanged: optionEnabled = programOption.isEnabled
    }
    Connections {
        target: programOption
        onIntervalIndexChanged: optionIndex = programOption.intervalIndex
    }

    //enable after value change
    onCurrentIndexChanged: if(updateProgramOptionOnChange && programOption.intervalIndex != currentIndex) programOption.intervalIndex = currentIndex
    onCurrentEnabledChanged: if(updateProgramOptionOnChange && programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
}
