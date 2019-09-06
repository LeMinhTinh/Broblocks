import bsh.eox6021 1.0


 ConfigTileToggle {
     property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

     visible: programDefinition.thermometer
     programOption: programDefinition.thermometer
     isOptionDeactivated: programOption.isDeactivated
     optionName: "Roast thermometer"
     optionIcon: "file:resources/icons/thermometer.png"
 }
