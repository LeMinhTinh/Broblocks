import QtQuick 2.12
import bsh.backend 1.0

ConfigTileTwoWheels {
    property ProgramIntegerIntervalOption programOption
    property bool updateProgramOptionOnChange: true

    function setByNumpad(value, enabled) {
        var timeValue = 3600 * Math.floor(value / 100) + 60 * (value % 100)
        var newIndex = Math.max(0, Math.min(programOption.intervalCount - 1, Math.floor((timeValue - programOption.startingValue) / programOption.intervalLength)));
        var newValue = programOption.startingValue + newIndex * programOption.intervalLength
        programOption.isEnabled = enabled
        programOption.setValue(newValue)
    }
    property Item numpadPanel
    numpadFunction: function () {
        numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": getMinutes(programOption.value()) + getHours(programOption.value()) * 100 , "separator": " ",
                             "units": [primaryOptionUnit, secondaryOptionUnit], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": true, "confirmCallback": setByNumpad, "maxDigits": [2, 2]},
                             1088, 462)
    }

    function createHourOptions(option) {
        var stringList = []
        for (var i = 0; i < Math.floor(option.intervalCount / 60); ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function createMinuteOptions(option) {
        var stringList = []
        for (var i = 0; i < 60; ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function updateProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        programOption.intervalIndex = currentPrimaryIndex * 60 + currentSecondaryIndex
    }

    primaryOption: createHourOptions(programOption)
    primaryPeriodOfWheelLabel: 2

    secondaryOption: createMinuteOptions(programOption)
    secondaryPeriodOfWheelLabel: 5

    optionEnabled: programOption.isEnabled

    currentEnabled: currentPrimaryIndex != 0 || currentSecondaryIndex != 0

    primaryOptionIndex: Math.floor(programOption.intervalIndex / 60)
    secondaryOptionIndex: programOption.intervalIndex % 60
    function updateOptionIndices() {
        primaryOptionIndex = Math.floor(programOption.intervalIndex / 60)
        secondaryOptionIndex = programOption.intervalIndex % 60
    }
    Component.onCompleted: updateOptionIndices()

    Connections {
        target: programOption
        onIsEnabledChanged: optionEnabled = programOption.isEnabled
        onIntervalIndexChanged: updateOptionIndices()
    }

    //enable after value change
    onCurrentPrimaryIndexChanged: if(updateProgramOptionOnChange && Math.floor(programOption.intervalIndex / 60) != currentPrimaryIndex) programOption.intervalIndex = currentPrimaryIndex * 60 + currentSecondaryIndex
    onCurrentSecondaryIndexChanged: if(updateProgramOptionOnChange && programOption.intervalIndex % 60 != currentSecondaryIndex) programOption.intervalIndex = currentPrimaryIndex * 60 + currentSecondaryIndex
    onCurrentEnabledChanged: if(updateProgramOptionOnChange && programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
}
