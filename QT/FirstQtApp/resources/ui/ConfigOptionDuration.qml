import bsh.eox6021 1.0

//配置时长面板

ConfigTileDuration {
     property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

     programOption: programDefinition.duration
     isOptionDeactivated: programOption.isDeactivated
     primaryOptionUnit: "h"
     secondaryOptionUnit: "m"
     seperator: " "
     isCircular: true
     optionName: "Duration"
     optionIcon: "file:resources/icons/duration.png"
     onReset: {
         programDefinition.duration.intervalIndex = 0
     }
     primaryPercentageOfSeperator: 0.03
     secondaryPercentageOfSeperator: 0.06
}
