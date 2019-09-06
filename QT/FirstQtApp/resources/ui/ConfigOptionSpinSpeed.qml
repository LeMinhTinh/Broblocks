import bsh.eox6021 1.0

ConfigTileIntervalWheel {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition
    property int defaultIndex: 1
    programOption: backend.currentProgram.definition.spinspeed
    isOptionDeactivated: programOption.isDeactivated
    numOfSideBars: 5
    visible: programDefinition.spinspeed
    optionUnit: " "
    optionIcon: "file:resources/icons/heat.png"
    optionName: "SpinSpeed"
    unitOnTop: false
    isCircular: true
    hasReset: false
    periodOfWheelLabel: 100
    //optionEnabled: false
    state: "overview"
    onReset: {
        programDefinition.spinspeed.intervalIndex = defaultIndex
    }
}
