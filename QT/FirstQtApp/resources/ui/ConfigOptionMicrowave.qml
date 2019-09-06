import bsh.eox6021 1.0

ConfigTileIntegerSlider {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    visible: programDefinition.microwave
    programOption: programDefinition.microwave
    isOptionDeactivated: programOption.isDeactivated
    optionIndex: programOption.currentIndex
    optionUnit: "W"
    optionName: "microwave"
    optionIcon: "file:resources/icons/microwave.png"
    unitOnTop: true
}
