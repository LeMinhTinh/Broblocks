import bsh.backend 1.0

ConfigTileIntervalWheel {
    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

    programOption: programDefinition.thermometer
    isOptionDeactivated: programOption.isDeactivated
    visible: programDefinition.thermometer
    optionName: isInOverviewMode ? "Braten-thermometer" : "Bratenthermometer"
    optionIcon: "file:resources/siemens/icons/icn_bratenthermometer.png"

    optionUnit: "°C"
    disabledValueLabel: "--"
    overviewDisabledValueLabel: "aus"
    showUnitForDisabledValue: true
    showOverviewUnitForDisabledValue: false
    unitOnTop: true
    isCircular: false
    hasReset: true
    periodOfWheelLabel: 2

    optionEnabled: currentIndex != 0
    referenceValue: "30"
    firstIndexIsDisabled: true
    onReset: programDefinition.thermometer.intervalIndex = 0
}
