import bsh.eox6021 1.0

 ConfigTileEndTime {
     property EOX6021Program program: backend.currentProgram

     programOption: program.endTime
     isOptionDeactivated: programOption.isDeactivated
     numOfSideBars: 4
     visible: programOption
     optionUnit: ""
     optionName: "Ends at"
     optionIcon: "file:resources/icons/end_at.png"
     isCircular: false
     periodOfWheelLabel: 2
     onReset: {
         programOption.intervalIndex = 0
     }
 }
