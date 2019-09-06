import QtQuick 2.12
import bsh.backend 1.0

ConfigTileMappedIntegerWheel {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    function setByNumpad(value, enabled) {
        var bestFit = Number.MAX_SAFE_INTEGER
        var newIndex
        for (var i = 0; i < options.length; ++i) {
            var fit = Math.abs(options[i] - value)
            if (fit < bestFit) {
                bestFit = fit
                newIndex = i
            }
        }
        programOption.currentIndex = newIndex
    }
    property Item numpadPanel
    numpadFunction: function () {
        numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": programOption.value(),
                             "units": [optionUnit], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": hasReset, "confirmCallback": setByNumpad, "maxDigits": [4]},
                             1088, 462)
    }

    ProgramIntegerMappingOption { id: defaultOption; isEnabled: false }
    programOption: programDefinition.weightToDuration ? programDefinition.weightToDuration : defaultOption
    isOptionDeactivated: programOption.isDeactivated
    visible: programDefinition.weightToDuration
    optionName: "Gewicht"
    optionIcon: "file:resources/siemens/icons/gewicht.png"

    optionUnit: "g"
    unitOnTop: false
    isCircular: false
    hasReset: false
    periodOfWheelLabel: 2
    onCurrentIndexChanged: programDefinition.duration.setValue(programOption.mappedOptions[currentIndex] * 60)
}
