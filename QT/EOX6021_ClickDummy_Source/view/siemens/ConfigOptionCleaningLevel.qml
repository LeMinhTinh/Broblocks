import bsh.backend 1.0

ConfigTileStringSlider {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    ProgramStringOption {
        id: defaultOption
        currentIndex: 0
        options: ["N/A"]
        isEnabled: false
    }
    programOption: programDefinition.cleaningLevel ? programDefinition.cleaningLevel : defaultOption

    visible: programDefinition.cleaningLevel
    isOptionDeactivated: programOption.isDeactivated
    optionIndex: programOption.currentIndex
    optionName: "Stufe"
    optionIcon: "file:resources/siemens/icons/reinigung.png"
    unitOnTop: true
    hasOffPosition: false

    onCurrentIndexChanged: programDefinition.duration.setValue((currentIndex + 1) * 30 * 60)
}
