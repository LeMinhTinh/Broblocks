import QtQuick 2.12
import bsh.backend 1.0

ConfigTileWheel {
    id: optionWheel

    function setByNumpad(value, enabled) {
        var newIndex = Math.max(firstIndexIsDisabled ? 1 : 0, Math.min(programOption.intervalCount, Math.floor((value - programOption.startingValue) / programOption.intervalLength)));
        var newValue = programOption.startingValue + newIndex * programOption.intervalLength
        programOption.isEnabled = enabled
        programOption.setValue(newValue)
    }
    property Item numpadPanel
    numpadFunction: function () {
        numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": programOption.value(),
                             "units": [optionUnit], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": hasReset, "confirmCallback": setByNumpad, "maxDigits": [3]},
                             1088, 462)
    }

    property ProgramIntegerIntervalOption programOption
    property bool updateProgramOptionOnChange: true
    property bool firstIndexIsDisabled: false

    function intervalToString(option) {
        var stringList = firstIndexIsDisabled ? [disabledValueLabel] : []
        for(var i = firstIndexIsDisabled ? 1 : 0; i <= option.intervalCount; ++i) {
            stringList.push((option.startingValue + i * option.intervalLength).toString())
        }
        return stringList
    }

    // propagate down
    options: intervalToString(programOption)
    optionIndex: programOption.intervalIndex
    optionEnabled: programOption.isEnabled
    // propagate up
    function updateProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.intervalIndex != currentIndex) programOption.intervalIndex = currentIndex
    }
    onCurrentIndexChanged: if(updateProgramOptionOnChange) updateProgram()
    onCurrentEnabledChanged: if(updateProgramOptionOnChange) updateProgram()
}
