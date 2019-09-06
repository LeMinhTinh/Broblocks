import QtQuick 2.11
import QtQuick.Layouts 1.11
import bsh.eox6021 1.0

Item {
    id: componentList

    property string targetTemperature: ""

    signal confirm()
    signal extendCalled()

    function getFinishText(target) {
        componentList.targetTemperature = target.toString()
        return preHeatFinishText
    }

    function getSteamOption() {
        return steamOption
    }

    function getMicrowaveOption() {
        return microwaveOption;
    }

    function getRemainingTimeOption() {
        return remainingTimeOption
    }

    function getFinishOptions() {
        return finishOptions
    }

    function getTemperatureOptions() {
        return temperatureOption
    }

    Component {
        id: preHeatFinishText
        Column {
            id: textColumn
            spacing: 30
            anchors.centerIn: parent
            TextLabel {
                id: message
                fontPixelSize: 46
                color: themedLightContrastColor
                text: "Target temperature reached"
            }
            Row {
                anchors.horizontalCenter: textColumn.horizontalCenter
                TextLabel {
                    id: valueLabel
                    fontPixelSize: 37
                    color: message.color
                    text: targetTemperature
                }
                TextLabel {
                    id: unitLabel
                    fontPixelSize: 0.5 * valueLabel.fontPixelSize
                    color: valueLabel.color
                    text: "°C"
                }
            }
        }
    }

    Component {
        id: steamOption
        Column {
            id: steamOptionColumn
            ConfigOptionSteam {
                id: configChoiceSteam
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
            }
            FooterButton {
                anchors.horizontalCenter: steamOptionColumn.horizontalCenter
                text: "Confirm"
                onClicked: {
                    configChoiceSteam.setProgram()
                    confirm()
                }
            }
        }
    }

    Component {
        id: microwaveOption
        Column {
            id: microwaveOptionColumn
            ConfigOptionMicrowave {
                id: configChoiceMicrowave
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
            }
            FooterButton {
                anchors.horizontalCenter: microwaveOptionColumn.horizontalCenter
                text: "Confirm"
                onClicked: {
                    configChoiceMicrowave.setProgram()
                    confirm()
                }
            }
        }
    }

    Component {
        id: remainingTimeOption
        Column {
            id: remainingTimeOptionColumn
            ConfigTileRemainingTime {
                id: configChoiceRemainingTime
                embedded: true
                isOptionDeactivated: false
                state: "open"
            }
            FooterButton {
                anchors.horizontalCenter: remainingTimeOptionColumn.horizontalCenter
                text: "Confirm"
                onClicked: {
                    configChoiceRemainingTime.setProgram()
                    confirm()
                }
            }
        }
    }

    Component {
        id: temperatureOption
        Column {
            id: temperatureOptionColumn
            ConfigOptionTemperature {
                id: configChoiceTemperature
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
            }
            FooterButton {
                anchors.horizontalCenter: temperatureOptionColumn.horizontalCenter
                text: "Confirm"
                onClicked: {
                    configChoiceTemperature.setProgram()
                    confirm()
                }
            }
        }
    }

    Component {
        id: finishOptions

        TextLabel {
            id: finishTitle
            fontPixelSize: 46
            color: 'white'
            text: program.definition.name + " finished!"
        }

    }
}


