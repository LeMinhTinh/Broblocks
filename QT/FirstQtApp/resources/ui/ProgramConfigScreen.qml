import QtQuick 2.11
import bsh.eox6021 1.0
import "./storage.js" as Storage 

//任务配置界面

FlickerScreen1 {
    id: root

    property EOX6021ProgramDefinition programDefinition: backend.currentProgram.definition
    property bool isEditingFavorite: false
    property ConfigTile previousOpenTile
    property ConfigTile currentOpenTile: temperatureTile
    property real desiredContentX
    property string favorite: Storage.getSetting("mySetting");

    
    contentEntryScale: 0.8
    initialBackgroundScale: 1.05
    targetBackgroundScale: 1.1
    
  


    property Animation tileAnimation: ParallelAnimation {
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
        SequentialAnimation {
            NumberAnimation {
                target: flickableItem
                property: "contentX"
                to: desiredContentX
                duration: 200
                easing.type: Easing.OutCubic
            }
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
        // 初始化数据库  
        Storage.initialize();  
        // 赋值  
        //Storage.setSetting("mySetting","0");  
        updateTilePositions()


        //获取一个值，并把它写在textDisplay里  
        //textDisplay.text = "The value of mySetting is:\n" + Storage.getSetting("mySetting");  
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
        // if a current open tile exists, calculate its x position in the flicker
        if (currentOpenTile) {
            var positionInFlicker
            if (previousOpenTile && previousOpenTile.positionInConfigScreen < currentOpenTile.positionInConfigScreen )
                positionInFlicker =(currentOpenTile.positionInConfigScreen-1) * (constants.overviewTileWidth+programList.spacing) + constants.openedConfigTileWidth
            else
                positionInFlicker  = currentOpenTile.positionInConfigScreen * (constants.overviewTileWidth+programList.spacing)

            // check if the tile is far to the left
            if (positionInFlicker - flickableItem.contentX < constants.overviewTileWidth)
                return Math.max(0, (currentOpenTile.positionInConfigScreen)*(constants.overviewTileWidth+programList.spacing))
            else
                return Math.max(0, (currentOpenTile.positionInConfigScreen-1)*(constants.overviewTileWidth+programList.spacing))
        } else {
            if (previousOpenTile) {
                return flickableItem.contentX - 248
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
                footer.infoBubble.show({"value": qsTr("Änderungen an \"" + programDefinition.name + "\" \n wurden gespeichert"), "iconSource": "file:resources/icons/edit.png"})
                isEditingFavorite = false
            } else {
                keyboardOverlay.readText("My Favorite", function(newName) {
                    programDefinition.name = newName
                    programDefinition.isFavorite = true
                    programLabel.text = newName   //sunjie
		    //favorite = true
		    //uiFavorite = true
		    Storage.setSetting("mySetting","1");  
                    //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                    var programCopy = backend.getProgramDefinitionCopy(programDefinition)
                    programCopy.origin = programCopy
                    programDefinition.origin = programCopy
                    backend.favorites.insert(programCopy, 0)
                    footer.infoBubble.show({"value": qsTr("\"" + programDefinition.name + "\" wurde\nim Favoriten-Menü gespeichert"), "iconSource": "file:resources/icons/like_active.png"})
                    isEditingFavorite = false
                })
            }
        }
    }

    function requestFavoriteNameChange() {
        keyboardOverlay.readText(programDefinition.name, function(newName) { programDefinition.name = newName })
    }

    function requestCancelEditingFavorite() {
        questionOverlay.confirm("Should it really be canceled? Changes will not be saved", "No", "Yes", function() {
            programDefinition.fetchDefinition(programDefinition.origin);
            isEditingFavorite = false
        })
    }

    function deleteFavorite()
    {
        questionOverlay.confirm("Do you wanna delete '" + programDefinition.name + "' ?", "Cancel", "Delete",
                                function() { isEditingFavorite = false; programDefinition.isFavorite = false; Storage.setSetting("mySetting","0"); backend.favorites.remove(programDefinition.origin); display.pop(display.get(2)) })
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
        runAnimation: false
        title: qsTr("Wash")
        backHandler: function(){ display.pop(display.get(2)) }
    }
    

    
    titleContent: Row {
        height: programLabel.height
        spacing: 32
        TextLabel {
            id: programLabel
            text: programDefinition.name
            fontPixelSize: constants.smallTitleSize
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
            anchors.bottom: programLabel.baseline
            anchors.bottomMargin: -3
            //source: programDefinition.isFavorite ? "file:resources/icons/like_active.png" : "file:resources/icons/like.png"
	    source: favorite == "1" ? "file:resources/icons/like_active.png" : "file:resources/icons/like.png"
            //color: isEditingFavorite ? "#666666" : programDefinition.isFavorite ? constants.defaultBlue : themedStrongContrastColor
	    color: isEditingFavorite ? "#666666" : favorite == "1" ? constants.defaultBlue : themedStrongContrastColor

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
            visible: true//programDefinition.isFavorite
            source: "file:resources/icons/edit.png"
            color: isEditingFavorite ? constants.defaultBlue : themedStrongContrastColor
            onClicked: toggleEditFavorite()
        }
    }

//    配置选项
    flickContent: Row {
        id: programList
        readonly property real backgroundRelativeX: -flickableItem.contentX + content.x + flickableItem.x
        readonly property real backgroundRelativeY: content.y + flickableItem.y

        spacing: 6
        // Add all possible options and decide if they are visible based on wether they are user hidden
        ConfigOptionTemperature {
            id: temperatureTile
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
        }
        ConfigOptionSpinSpeed {
            id: spinspeedTile
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
      }
 /*       ConfigOptionQuickHeat {
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            isEdited: isEditingFavorite
            onIsOptionDeactivatedChanged: {
                if (isOptionDeactivated && optionEnabled && display.currentItem === root) {
                    footer.infoBubble.show({"value": "Fast heating deactivated", "iconSource": "file:resources/icons/heat.png"})
                }
            }
        }
 */
        ConfigOptionSteam {
            visible: false
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
            onIsOptionDeactivatedChanged: {
                if (isOptionDeactivated && (optionEnabled || manualChecked) && display.currentItem === root) {
                    footer.infoBubble.show({"value": "Steam addition deactivated", "iconSource": "file:resources/icons/steam_encore.png"})
                }
            }
        }
        ConfigOptionMicrowave {
            visible: false
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
            onIsOptionDeactivatedChanged: {
                if (isOptionDeactivated && (optionEnabled || manualChecked) && display.currentItem === root) {
                    footer.infoBubble.show({"value": "Microwave disabled", "iconSource": "file:resources/icons/microwave.png"})
                }
            }
        }
        ConfigOptionDuration {
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
        }
        ConfigOptionEndTime {
            //visible: false
            backgroundSource: blurredBackground
            backgroundRelativeX: programList.backgroundRelativeX
            backgroundRelativeY: programList.backgroundRelativeY
            onClicked: if (!isOptionDeactivated) toggleTile(this)
            onCloseRequest: toggleTile(this)
            isEdited: isEditingFavorite
        }
        //        ConfigOptionThermometer {
        //            backgroundSource: blurredBackground
        //            backgroundRelativeX: programList.backgroundRelativeX
        //            backgroundRelativeY: programList.backgroundRelativeY
        //            isEdited: isEditingFavorite
        //        }
//        ConfigTileSymbolic {
//            optionName: "Add next step"
//            optionIcon: "file:resources/icons/plus.png"
//            backgroundSource: blurredBackground
//            backgroundRelativeX: programList.backgroundRelativeX
//            backgroundRelativeY: programList.backgroundRelativeY
//            isEdited: isEditingFavorite

//        }
    }

    footer: Footer {
        id: footer
        backgroundSource: blurredBackground
        actionButtonText: isEditingFavorite ? qsTr("Save") : qsTr("Start")
        onAction: {
            if (isEditingFavorite) {
                saveFavorite()
            } else {
                display.push("RunningScreen.qml")
            }
        }
        cancelButtonText: isEditingFavorite ? qsTr("Exit") : ""
        onCancel: {
            if (isEditingFavorite) {
                toggleEditFavorite()
            } else {
                display.pop()
            }
        }
    }
}
