import QtQuick 2.12
import bsh.backend 1.0

ConfigTileTwoWheels {
    property int remainingTime: backend.currentProgram.remainingTime

    function setByNumpad(value, enabled) {
        var timeValue = 3600 * Math.floor(value / 100) + 60 * (value % 100)
        var newIndex = Math.max(0, Math.min(60 * 24 - 1, Math.floor(timeValue / 60)));
        var newValue = newIndex * 60
        backend.currentProgram.remainingTime = newValue <= 0 ? -1 : newValue
    }
    property Item numpadPanel
    numpadFunction: function () {
        numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": getMinutes(remainingTime) + getHours(remainingTime) * 100 , "separator": " ",
                             "units": [primaryOptionUnit, secondaryOptionUnit], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": true, "confirmCallback": setByNumpad, "maxDigits": [2, 2]},
                             1088, 462)
    }

    primaryOptionUnit: "h"
    secondaryOptionUnit: "min"
    separator: " "
    isCircular: true
    optionName: "Dauer"
    optionIcon: "file:resources/siemens/icons/icn_dauer_running.png"
    onReset: {
        //TODO Quick Hack to force update from already reset state
        primaryOptionIndex = 1
        secondaryOptionIndex = 1
        primaryOptionIndex = 0
        secondaryOptionIndex = 0
    }

    function createHourOptions() {
        var stringList = []
        for (var i = 0; i < 24; ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function createMinuteOptions() {
        var stringList = []
        for (var i = 0; i < 60; ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function updateProgram() {
        var remainingTime = currentPrimaryIndex * 3600 + currentSecondaryIndex * 60
        backend.currentProgram.remainingTime = remainingTime <= 0 ? -1 : remainingTime
    }

    primaryOption: createHourOptions()
    primaryOptionIndex: remainingTime > 0 ? Math.floor(remainingTime / 3600) : 0
    primaryPeriodOfWheelLabel: 2

    secondaryOption: createMinuteOptions()
    secondaryOptionIndex: remainingTime > 0 ? Math.floor(remainingTime / 60) % 60 : 0
    secondaryPeriodOfWheelLabel: 5

    optionEnabled: true

    currentEnabled: currentPrimaryIndex != 0 || currentSecondaryIndex != 0
}
