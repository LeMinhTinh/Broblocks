import bsh.backend 1.0

ConfigTileToggle {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    visible: programDefinition.quickHeat
    programOption: programDefinition.quickHeat
    isOptionDeactivated: programOption.isDeactivated
    optionName: "Schnellaufheizen"
    optionIcon: "file:resources/siemens/icons/icn_schnellaufheizen_running.png"
}
