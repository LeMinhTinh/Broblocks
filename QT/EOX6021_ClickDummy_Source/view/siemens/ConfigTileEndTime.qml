import QtQuick 2.12
import bsh.backend 1.0

ConfigTileWheel {
    property bool alwaysEnabled: false
    property int secondInteval: 5 * 60
    property int intervalCount: 24 * 60 * 60 / secondInteval
    property int duration: backend.currentProgram.definition.duration.startingValue + backend.currentProgram.definition.duration.intervalIndex * backend.currentProgram.definition.duration.intervalLength
    property int startingValue: secondInteval * Math.ceil((backend.wallClock + duration) / secondInteval)
    property int waitTime: (currentIndex > 0) ? (startingValue + (currentIndex - 1) * secondInteval - backend.wallClock - duration) : 0
    onWaitTimeChanged: if (backend.currentProgram.initialWaitingTime !== waitTime) backend.currentProgram.initialWaitingTime = waitTime

    function setByNumpad(value, enabled) {
        var timeValue = 3600 * Math.floor(value / 100) + 60 * ((value % 100) % 60)
        var newWaitTime = enabled ? Math.max(0, timeValue - backend.wallClock - duration) : 0
        if (backend.currentProgram.initialWaitingTime !== newWaitTime) backend.currentProgram.initialWaitingTime = newWaitTime
    }
    property Item numpadPanel
    numpadFunction: function () {
        numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": getMinutes(startingValue + (currentIndex-1) * secondInteval) + getHours(startingValue + (currentIndex-1) * secondInteval) * 100 , "separator": ":",
                             "units": ["", ""], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": true, "confirmCallback": setByNumpad, "maxDigits": [2, 2]},
                             1088, 462)
    }

    optionUnit: ""
    optionName: "Fertig um"
    optionIcon: "file:resources/siemens/icons/icn_endet_um.png"
    isCircular: false
    periodOfWheelLabel: 2
    overviewIconMargin: 24
    disabledValueLabel: "--:--"
    isOptionDeactivated: !backend.currentProgram.definition.duration.isEnabled
    Connections {
        target: backend.currentProgram.definition.duration
        onIsEnabledChanged: isOptionDeactivated = !backend.currentProgram.definition.duration.isEnabled
    }
    options: [""]
    function recalculateOptions() {
        var stringList = alwaysEnabled ? [getHhMmFromSeconds(backend.wallClock + duration)] : [disabledValueLabel]
        var value = startingValue
        for(var i = 0; i < intervalCount; ++i) {
           stringList.push(getHhMmFromSeconds(value))
           value += secondInteval
        }
        options = stringList
    }
    onOpening: recalculateOptions()
    onStartingValueChanged: recalculateOptions()

    optionEnabled: alwaysEnabled || (backend.currentProgram.initialWaitingTime > 0)
    optionIndex: (backend.currentProgram.initialWaitingTime > 0) ? (Math.floor(backend.currentProgram.initialWaitingTime / secondInteval) + 1) : 0

    onReset: {
        backend.currentProgram.initialWaitingTime = 0
    }
}
