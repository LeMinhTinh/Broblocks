import bsh.backend 1.0

ConfigTileIntegerSlider {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    visible: programDefinition.microwave
    programOption: programDefinition.microwave
    isOptionDeactivated: programOption.isDeactivated
    optionIndex: programOption.currentIndex
    optionUnit: "W"
    optionName: "Mikrowelle"
    optionIcon: "file:resources/siemens/icons/icn_mikrowelle_running.png"
    unitOnTop: true
}
