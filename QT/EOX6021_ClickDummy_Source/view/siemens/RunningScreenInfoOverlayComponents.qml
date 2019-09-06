import QtQuick 2.12
import QtQuick.Layouts 1.12
import bsh.backend 1.0

Item {
    id: componentList

    property alias cleaningLevelOption: cleaningLevelOption
    Component {
        id: cleaningLevelOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigOptionCleaningLevel {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias steamOption: steamOption
    Component {
        id: steamOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigOptionSteam {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias microwaveOption: microwaveOption
    Component {
        id: microwaveOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigOptionMicrowave {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias thermometerOption: thermometerOption
    Component {
        id: thermometerOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigOptionThermometer {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias remainingTimeOption: remainingTimeOption
    Component {
        id: remainingTimeOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigTileRemainingTime {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                property int currentRemainingTime: backend.currentProgram.remainingTime
                remainingTime: (currentRemainingTime <= 0 ? 5 : Math.ceil(currentRemainingTime / 60)) * 60
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias temperatureOption: temperatureOption
    Component {
        id: temperatureOption
        Item {
            Row {
                id: optionNameLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.top
                anchors.verticalCenterOffset: 48
                spacing: 20

                Icon {
                    anchors.verticalCenter: parent.verticalCenter
                    source: configChoice.optionIcon
                    color: themedLightContrastColor
                }
                TextLabel {
                    anchors.verticalCenter: parent.verticalCenter
                    fontPixelSize: constants.descriptionTextSize
                    color: themedLightContrastColor
                    text: configChoice.optionName
                }
            }
            ConfigOptionTemperature {
                id: configChoice
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 10
                embedded: true
                isOptionDeactivated: false
                state: "open"
                updateProgramOptionOnChange: false
                showControlDescription: false
            }
            FooterButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                text: "Übernehmen"
                onClicked: {
                    configChoice.updateProgram()
                    overlayBase.close()
                }
            }
        }
    }

    property alias finishOptions: finishOptions
    Component {
        id: finishOptions

        Item {
            id: finishOverlay
            Column {
                spacing: 37
                anchors.centerIn: parent
                RowLayout {
                    spacing: 0
                    anchors.left: parent.left
                    anchors.right: parent.right
                    TextLabel {
                        id: finishTitle
                        Layout.alignment: Qt.AlignBottom | Qt.AlignLeft
                        fontPixelSize: constants.smallTitleTextSize
                        color: constants.blueThemeLightContrast
                        text: program.definition.name + " ist fertig!"
                    }
                    IconButton {
                        id: favoriteStar
                        Layout.alignment: Qt.AlignBottom | Qt.AlignLeft
                        Layout.leftMargin: 26
                        touchWidth: iconWidth + 24
                        touchHeight: iconHeight + 24
                        source: program.definition.isFavorite ? "file:resources/siemens/icons/favourite_filled.png" : "file:resources/siemens/icons/favourite.png"
                        color: program.definition.isFavorite ? constants.defaultBlue : themedStrongContrastColor
                        onClicked: {
                            if (program.definition.isFavorite) {
                                modalOverlay.openURL("QuestionOverlay.qml", {
                                                      "question": "Wollen sie diesen Favorit\nwirklich löschen?",
                                                      "cancelAnswer": "Abbrechen",
                                                      "actionAnswer": "Löschen",
                                                      "confirmCallback": function() { program.definition.isFavorite = false; backend.favorites.remove(program.definition.origin) }
                                                      }, 618, 216, false)
                            } else {
                                if (program.definition.favoriteTileImage) {
                                    keyboardOverlay.readText("Mein Favorit", function(newName) {
                                        program.definition.name = newName
                                        program.definition.isFavorite = true
                                        //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                                        var programCopy = backend.getProgramDefinitionCopy(program.definition)
                                        programCopy.origin = programCopy
                                        program.definition.origin = programCopy
                                        backend.favorites.insert(programCopy, 0)
                                    })
                                }
                            }
                        }
                    }
                    Item {
                        Layout.fillWidth: true
                    }
                    ConfigString {
                        Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                        Layout.rightMargin: 36

                        iconSource: "file:resources/siemens/icons/temperature_small.png"
                        iconColor: constants.blueThemeLightContrast
                        iconMargin: 26
                        value: backend.currentProgram.definition.temperature.value()
                        unit: "°C"
                        unitOnTop: true
                        textSize: constants.headerTextSize
                        valueColor: constants.blueThemeLightContrast
                        iconBottomAligned: true
                    }
                    ConfigString {
                        property int elapsedTime: backend.currentProgram.definition.duration.value()
                        property int hours: getHours(elapsedTime)
                        property int minutes: getMinutes(elapsedTime)
                        property int seconds: getSeconds(elapsedTime)
                        property bool hasHours: hours > 0

                        Layout.alignment: Qt.AlignBottom | Qt.AlignRight

                        iconSource: "file:resources/siemens/icons/duration_small.png"
                        iconColor: constants.blueThemeLightContrast
                        iconMargin: 26
                        value: timeString(hasHours ? hours : minutes)
                        unit: hasHours ? "h" : "min"
                        textSize: constants.headerTextSize
                        valueSecondary: timeString(hasHours ? minutes : seconds)
                        unitSecondary: hasHours ? "min" : "s"
                        separatorString: " "
                        unitOnTop: false
                        valueColor: constants.blueThemeLightContrast
                        iconBottomAligned: true
                    }
                }
                Row {
                    id: optionRow
                    spacing: approximateInNativeResolution(6)
                    ProgramTileButton {
                        title: "Verlängern"
                        iconSource: "file:resources/siemens/icons/icn_dauer_finish.png"
                        // TODO finishOverlay.parent.parent.parent is a hack that should be replacedbsomething like setting overlay item in loaded items if a certain variable exists
                        onClicked: modalOverlay.open(boxInput.remainingTimeOption, 1088, 462, function() { program.status = EOX6021Program.HEATING; finishOverlay.parent.parent.parent.close() })
                        backgroundColor: themedStrongContrastColor
                        backgroundOpacity: 0.2
                        textAreaHeight: 104
                        iconCenterOffsetToTop: 87
                        hasShine: false
                        hasShadow: false
                    }
                    ProgramTileButton {
                        title: "Warmhalten"
                        iconSource: "file:resources/siemens/icons/icn_warmhalten_finish.png"
                        backgroundColor: themedStrongContrastColor
                        backgroundOpacity: 0.2
                        textAreaHeight: 104
                        iconCenterOffsetToTop: 87
                        hasShine: false
                        hasShadow: false
                    }
                    ProgramTileButton {
                        title: "Grillen"
                        iconSource: "file:resources/siemens/icons/icn_grill_finish.png"
                        backgroundColor: themedStrongContrastColor
                        backgroundOpacity: 0.2
                        textAreaHeight: 104
                        iconCenterOffsetToTop: 87
                        hasShine: false
                        hasShadow: false
                    }
                    ProgramTileButton {
                        title: "Trocknen"
                        iconSource: "file:resources/siemens/icons/icn_trocknen_finish.png"
                        backgroundColor: themedStrongContrastColor
                        backgroundOpacity: 0.2
                        textAreaHeight: 104
                        iconCenterOffsetToTop: 87
                        hasShine: false
                        hasShadow: false
                    }
                }
            }
        }
    }
}


