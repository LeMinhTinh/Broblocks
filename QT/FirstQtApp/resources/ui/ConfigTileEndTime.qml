import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileWheel {
    id: optionWheel

    property ProgramIntegerIntervalOption programOption
    property bool updateProgramOptionOnChange: true

    function setOptionList(option) {
        option.startingValue = Math.floor(backend.wallClock / 60) + backend.currentProgram.definition.duration.value();

        var stringList = []
        var roundedStartingValue = option.startingValue + (option.intervalLength-(option.startingValue%option.intervalLength))
        for(var i=0; i<=option.intervalCount; ++i) {
           var valueInMinutes = roundedStartingValue + i * option.intervalLength
           var hour = Math.floor(valueInMinutes / 60) % 24
           var minutes = valueInMinutes % 60

           var stringValue = (hour<10) ? "0" : ""
           stringValue += hour.toString()
           stringValue += (minutes<10) ? ":0" : ":"
           stringValue += minutes.toString()

           stringList.push(stringValue)
        }

        return stringList
    }

    options: [""]
    optionIndex: programOption.intervalIndex
    optionEnabled: programOption.isEnabled

    currentEnabled: currentIndex != 0

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

    onOpening: {
        options = setOptionList(programOption)
    }

    currentValue: programOption.isEnabled ? options[optionIndex] : "--:--"
}
