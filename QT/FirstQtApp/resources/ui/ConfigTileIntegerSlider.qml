import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileSlider {
    id: optionSlider

    property var stringList
    property ProgramIntegerOption programOption
    property bool updateProgramOptionOnChange: true

    function setProgram() {
        if(programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
        if(programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    }

    onProgramOptionChanged: {
        for (var i = 0; i< programOption.options.length; i++) {
            if(i==0)
                stringList = programOption.options[i].toString()
            else
                stringList = [stringList, programOption.options[i].toString()]
        }
    }

    options: programOption.options
    optionEnabled: programOption.isEnabled
    optionIndex: programOption.currentIndex

    Connections {
        target: programOption
        onIsEnabledChanged: optionEnabled = programOption.isEnabled
    }
    Connections {
        target: programOption
        onCurrentIndexChanged: optionIndex = programOption.currentIndex
    }

    //enable after value change
    onCurrentIndexChanged: if(updateProgramOptionOnChange && programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    onCurrentEnabledChanged: if(updateProgramOptionOnChange && programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
}
