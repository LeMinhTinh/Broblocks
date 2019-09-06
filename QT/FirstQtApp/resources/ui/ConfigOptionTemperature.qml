import bsh.eox6021 1.0

ConfigTileIntervalWheel {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    property int defaultIndex: 20
    programOption: backend.currentProgram.definition.temperature
    isOptionDeactivated: programOption.isDeactivated
    numOfSideBars: 5
    visible: programDefinition.temperature
    optionUnit: "°C"
    optionIcon: "file:resources/icons/temperature.png"
    optionName: "Temperature"
    unitOnTop: true
    isCircular: false
    hasReset: false
    periodOfWheelLabel: 2
    state: "open"
    onReset: {
        programDefinition.temperature.intervalIndex = defaultIndex
    }
}
