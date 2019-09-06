import QtQuick 2.12
import bsh.backend 1.0

FlickerScreen {
    id: root

    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition
    property bool isEditingFavorite: false
    property ConfigTile previousOpenTile
    property ConfigTile currentOpenTile
    property real desiredContentX

    contentExitScale: 1.2
    contentEntryScale: 0.8

    property Animation tileAnimation: ParallelAnimation {
        NumberAnimation {
            target: flickableItem
            property: "contentX"
            to: desiredContentX
            duration: 200
            easing.type: Easing.OutCubic
        }
        PropertyAction {
            target: previousOpenTile
            property: "state"
            value: "overview"
        }
        PropertyAction {
            target: currentOpenTile
            property: "state"
            value: "open"
        }
    }

    property TileButton dummy: null

    function updateTilePositions() {
        var position = 0
        for (var i=0; i<programList.children.length; i++) {
            if (programList.children[i].visible) {
                programList.children[i].positionInConfigScreen = position
                ++position
            }
        }
    }

    Component.onCompleted: {
        updateTilePositions()
    }

    onClicked: {
        if (currentOpenTile) toggleTile(currentOpenTile)
    }

    function toggleTile(tile)
    {
        if (!tileAnimation.running) {
            if (tile.state === "open" ) {
                if (currentOpenTile) previousOpenTile = currentOpenTile
                currentOpenTile = dummy
            } else {
                previousOpenTile = currentOpenTile
                currentOpenTile = tile
            }
            desiredContentX = calculateDesiredFlickablePosition()
            tileAnimation.start()
        }
    }

    function calculateDesiredFlickablePosition() {
        if (currentOpenTile) {
            // calculate current x position in the flicker (pre opening animation)
            var currentPositionInFlicker = currentOpenTile.positionInConfigScreen * (constants.overviewTileWidth + programList.spacing)
            if (previousOpenTile && previousOpenTile.positionInConfigScreen < currentOpenTile.positionInConfigScreen )
                currentPositionInFlicker += constants.openedConfigTileWidth - constants.overviewTileWidth

            var newPositionInFlicker = (currentOpenTile.positionInConfigScreen - 1) * (constants.overviewTileWidth + programList.spacing)
            // check if the tile should be visbibly opened in the center
            if (currentPositionInFlicker - flickableItem.contentX <= constants.overviewTileWidth) {
                newPositionInFlicker += constants.overviewTileWidth + programList.spacing
            }

            return Math.min(Math.max(0, newPositionInFlicker), (programList.children.length - 1) * (constants.overviewTileWidth + programList.spacing) + constants.openedConfigTileWidth - flickableItem.width)
        } else {
            if (previousOpenTile) {
                return flickableItem.contentX - 0.5 * (constants.openedConfigTileWidth - constants.overviewTileWidth)
            } else {
                return flickableItem.contentX
            }
        }
    }

    function saveFavorite()
    {
        if (programDefinition.favoriteTileImage) {
            if (programDefinition.isFavorite) {
                programDefinition.origin.fetchDefinition(programDefinition)
                footer.infoBubble.show({"value": qsTr("Änderungen an \"" + programDefinition.name + "\" \n wurden gespeichert"), "iconSource": "file:resources/siemens/icons/icn_edit.png"})
                isEditingFavorite = false
            } else {
                keyboardOverlay.readText("Mein Favorit", function(newName) {
                    programDefinition.name = newName
                    programDefinition.isFavorite = true
                    //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                    var programCopy = backend.getProgramDefinitionCopy(programDefinition)
                    programCopy.origin = programCopy
                    programDefinition.origin = programCopy
                    backend.favorites.insert(programCopy, 0)
                    footer.infoBubble.show({"value": qsTr("\"" + programDefinition.name + "\" wurde\nim Favoriten-Menü gespeichert"), "iconSource": "file:resources/siemens/icons/favourite_filled.png"})
                    isEditingFavorite = false
                })
            }
        }
    }

    function requestFavoriteNameChange() {
        keyboardOverlay.readText(programDefinition.name, function(newName) { programDefinition.name = newName })
    }

    function requestCancelEditingFavorite() {
        modalOverlay.openURL("QuestionOverlay.qml", {
                              "question": "Soll wirklich abgebrochen werden?\nÄnderungen werden nicht gespeichert",
                              "cancelAnswer": "Nein",
                              "actionAnswer": "Ja",
                              "confirmCallback": function() { programDefinition.fetchDefinition(programDefinition.origin); isEditingFavorite = false }
                              }, 618, 216)
    }

    function deleteFavorite()
    {
        modalOverlay.openURL("QuestionOverlay.qml", {
                              "question": "Wollen sie diesen Favorit\nwirklich löschen?",
                              "cancelAnswer": "Abbrechen",
                              "actionAnswer": "Löschen",
                              "confirmCallback": function() { isEditingFavorite = false; programDefinition.isFavorite = false; backend.favorites.remove(programDefinition.origin); display.pop(display.get(2)) }
                              }, 618, 216, false)
    }

    function toggleEditFavorite()
    {
        if (isEditingFavorite) {
            requestCancelEditingFavorite()
        } else {
            if (programDefinition.favoriteTileImage) {
                isEditingFavorite = true
            }
        }
    }

    backgroundSource: programDefinition.bgImage

    header: Header {
        hasBackButton: true
    }

    titleContent: Row {
        height: programLabel.height
        spacing: 32
        TextLabel {
            id: programLabel
            text: programDefinition.name
            fontPixelSize: constants.smallTitleTextSize
            color: themedLightContrastColor
            MouseArea {
                id: labelEditButton
                visible: isEditingFavorite
                anchors.centerIn: parent
                width: parent.contentWidth + 16
                height: parent.contentHeight + 16
                onClicked: requestFavoriteNameChange()
                TileEditBorder {}
            }
        }
        IconButton {
            id: favoriteStar
            visible: programDefinition.favoriteTileImage
            anchors.bottom: programLabel.baseline
            anchors.bottomMargin: -3
            touchWidth: iconWidth + 24
            touchHeight: iconHeight + 24
            source: programDefinition.isFavorite ? "file:resources/siemens/icons/favourite_filled.png" : "file:resources/siemens/icons/favourite.png"
            color: isEditingFavorite ? "#666666" : programDefinition.isFavorite ? constants.defaultBlue : themedStrongContrastColor
            onClicked: {
                if (!isEditingFavorite) {
                    if (programDefinition.isFavorite) {
                        deleteFavorite()
                    } else {
                        saveFavorite()
                    }
                }
            }
        }
        IconButton {
            id: editButton
            anchors.bottom: programLabel.baseline
            touchWidth: iconWidth + 24
            touchHeight: iconHeight + 24
            visible: programDefinition.isFavorite
            source: "file:resources/siemens/icons/icn_edit.png"
            color: isEditingFavorite ? constants.defaultBlue : themedStrongContrastColor
            onClicked: toggleEditFavorite()
        }
    }

    flickContent: Row {
        id: programList
        readonly property real backgroundRelativeX: -flickableItem.contentX + contentContainer.x + flickableItem.x
        readonly property real backgroundRelativeY: contentContainer.y + flickableItem.y

        spacing: approximateInNativeResolution(6)
        // Add all possible options and decide if they are visible based on wether they are user hidden
        ConfigOptionWeight {
            id: weightTile
            openWidth: 672
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
        }
        ConfigOptionCleaningLevel {
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
        }
        ConfigTileEndTime {
            openWidth: 672
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: if (!isOptionDeactivated) toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
            //alwaysEnabled: true
        }
        ConfigTile {
            openWidth: 672
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            overview: ConfigOverview {
                anchors.fill: parent
                optionName: "Tipp"
                iconSource: "file:resources/siemens/icons/tipp.png"
                isEnabled: false
            }
            isEdited: isEditingFavorite
        }
    }

    footer: Footer {
        id: footer
        backgroundSource: blurredBackground
        actionButtonText: isEditingFavorite ? qsTr("Speichern") : qsTr("Start")
        onAction: {
            if (isEditingFavorite) {
                saveFavorite()
            } else {
                display.push("RunningScreen.qml")
            }
        }
        cancelButtonText: isEditingFavorite ? qsTr("Abbrechen") : ""
        onCancel: {
            if (isEditingFavorite) {
                toggleEditFavorite()
            } else {
                display.pop()
            }
        }
        ConfigString {
            id: durationLabel
            anchors.left: footer.infoButton.right
            anchors.leftMargin: 18
            anchors.verticalCenter: footer.infoButton.verticalCenter
            textSize: constants.runningSmallConfigTextSize
            unit: "h"
            unitSecondary: "m"
            separatorString: " "
            unitOnTop: false
            value: timeString(getHours(duration))
            valueSecondary: timeString(getMinutes(duration))
            iconSource: "file:resources/siemens/icons/duration_small.png"
            iconColor: themedLightContrastColor
            valueColor: themedLightContrastColor
            property int duration: root.programDefinition.duration.value()
            Connections {
                target: root.programDefinition.duration
                onIntervalIndexChanged: durationLabel.duration = root.programDefinition.duration.value()
            }
        }

        Row {
            id: preparationLabel
            anchors.left: durationLabel.right
            anchors.leftMargin: 49
            anchors.verticalCenter: footer.infoButton.verticalCenter
            spacing: 24
            Icon {
                anchors.verticalCenter: parent.verticalCenter
                source: "file:resources/siemens/icons/icn_dampfzugabe_running.png"
                color: themedLightContrastColor
                visible: root.programDefinition.steam && root.programDefinition.steam.isEnabled
            }
            Icon {
                anchors.verticalCenter: parent.verticalCenter
                source: "file:resources/siemens/icons/icn_mikrowelle_running.png"
                color: themedLightContrastColor
                visible: root.programDefinition.microwave && root.programDefinition.microwave.isEnabled
            }
            Icon {
                anchors.verticalCenter: parent.verticalCenter
                source: "file:resources/siemens/icons/icn_bratenthermometer_running.png"
                color: themedLightContrastColor
                visible: root.programDefinition.thermometer && root.programDefinition.thermometer.isEnabled
            }
        }
    }
}
