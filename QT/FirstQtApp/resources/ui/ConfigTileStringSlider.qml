import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileSlider {
    property ProgramStringOption programOption
    property bool updateProgramOptionOnChange: true

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
    Connections {
        target: programOption
        onIsInAlternativeModeChanged: manualChecked = programOption.isInAlternativeMode
    }

    //enable after value change
    onCurrentIndexChanged: {
        if(updateProgramOptionOnChange && programOption.currentIndex != currentIndex) programOption.currentIndex = currentIndex
    }
    onCurrentEnabledChanged: {
        if(updateProgramOptionOnChange && programOption.isEnabled != currentEnabled) programOption.isEnabled = currentEnabled
    }

    onManualCheckedChanged: {
        if(updateProgramOptionOnChange && programOption.isInAlternativeMode != manualChecked) programOption.isInAlternativeMode = manualChecked
    }
}
