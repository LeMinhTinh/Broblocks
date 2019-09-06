import bsh.backend 1.0

GenericListModel {
    EOX6021ProgramDefinition {
        name: qsTr("Eco Clean")
        tileText: qsTr("Eco Clean")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze.png"
        bgImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        runningImage: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"
        isCleaningProgram: true

        duration: ProgramIntegerIntervalOption {
            startingValue: 30 * 60
            intervalLength: 60
            intervalCount: 24*60
            intervalIndex: 0
            isEnabled: true
        }

        temperature: ProgramIntegerIntervalOption {
            startingValue: 60
            intervalLength: 5
            intervalCount: 48
            intervalIndex: 20
        }
        quickHeat: ProgramBooleanOption {
            isEnabled: false
        }
        steam: ProgramStringOption {
            isEnabled: false
        }
        microwave: ProgramIntegerOption {
            isEnabled: false
        }
        thermometer: ProgramIntegerIntervalOption {
            isEnabled: false
        }

        cleaningLevel: ProgramStringOption {
            currentIndex: 0
            options: ["1", "2", "3"]
        }
    }

    EOX6021ProgramDefinition {
        name: qsTr("Easy Clean")
        tileText: qsTr("Easy Clean")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze.png"
        isCleaningProgram: true
    }

    EOX6021ProgramDefinition {
        name: qsTr("Trocknen")
        tileText: qsTr("Trocknen")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze.png"
        isCleaningProgram: true
    }

    EOX6021ProgramDefinition {
        name: qsTr("Entkalken")
        tileText: qsTr("Entkalken")
        tileIcon: "file:resources/siemens/icons/ovenPrograms/Ober-_Unterhitze.png"
        isCleaningProgram: true
    }
}
