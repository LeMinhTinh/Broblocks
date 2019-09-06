import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileTwoWheels {
    property ProgramIntegerIntervalOption programOption
    property bool updateProgramOptionOnChange: true

    function createHourOptions(option) {
        var stringList = []
        for (var i=0; i<Math.floor(option.intervalCount/60); i++) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function createMinuteOptions(option) {
        var stringList = []
        for (var i=0; i<60; i++) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function setProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        programOption.intervalIndex = currentPrimaryIndex * 60 + currentSecondaryIndex
    }

    primaryOption: createHourOptions(programOption)
    primaryOptionIndex: Math.floor(programOption.intervalIndex / 60)
    primaryNumOfSideBars: 3
    primaryPeriodOfWheelLabel: 1

    secondaryOption: createMinuteOptions(programOption)
    secondaryOptionIndex: programOption.intervalIndex % 60
    secondaryNumOfSideBars: 7
    secondaryPeriodOfWheelLabel: 5

    optionEnabled: programOption.isEnabled

    currentEnabled: currentPrimaryIndex != 0 || currentSecondaryIndex != 0

    Connections {
        target: programOption
        onIsEnabledChanged: optionEnabled = programOption.isEnabled
    }
    Connections {
        target: programOption
        onIntervalIndexChanged: {
            primaryOptionIndex = Math.floor(programOption.intervalIndex / 60)
            secondaryOptionIndex = programOption.intervalIndex % 60
        }
    }

    //enable after value change
    onCurrentPrimaryIndexChanged: if(updateProgramOptionOnChange && Math.floor(programOption.intervalIndex / 60) != currentPrimaryIndex) programOption.intervalIndex = currentPrimaryIndex * 60 + programOption.intervalIndex % 60
    onCurrentSecondaryIndexChanged: if(updateProgramOptionOnChange && programOption.intervalIndex % 60 != currentSecondaryIndex) programOption.intervalIndex = Math.floor(programOption.intervalIndex / 60) * 60 + currentSecondaryIndex
    onCurrentEnabledChanged: if(updateProgramOptionOnChange && programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
}
