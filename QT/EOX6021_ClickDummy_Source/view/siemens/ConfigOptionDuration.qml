import bsh.backend 1.0

ConfigTileDuration {
     property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition

     programOption: programDefinition.duration
     isOptionDeactivated: programOption.isDeactivated
     primaryOptionUnit: "h"
     secondaryOptionUnit: "min"
     separator: " "
     isCircular: true
     optionName: "Dauer"
     optionIcon: "file:resources/siemens/icons/icn_dauer_running.png"
     onReset: {
         programDefinition.duration.intervalIndex = 0
     }
     overviewIconMargin: 10
}
