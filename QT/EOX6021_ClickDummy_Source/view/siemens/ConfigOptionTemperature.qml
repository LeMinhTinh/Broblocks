import bsh.backend 1.0

ConfigTileIntervalWheel {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    programOption: programDefinition.temperature
    isOptionDeactivated: programOption.isDeactivated
    visible: programDefinition.temperature
    optionName: "Temperatur"
    optionIcon: "file:resources/siemens/icons/temperature_small.png"

    optionUnit: "°C"
    unitOnTop: true
    isCircular: false
    hasReset: false
    periodOfWheelLabel: 2
    state: "open"
}
