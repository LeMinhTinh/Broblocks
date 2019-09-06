import bsh.eox6021 1.0

ConfigTileToggle {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    visible: programDefinition.quickHeat
    programOption: programDefinition.quickHeat
    isOptionDeactivated: programOption.isDeactivated
//    optionName: "fast heating"
    optionName: 'Toggle'
    optionIcon: "file:resources/icons/heating.png"
}