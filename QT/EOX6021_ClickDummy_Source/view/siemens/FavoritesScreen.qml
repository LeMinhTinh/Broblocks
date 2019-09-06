import QtQuick 2.12
import QtQuick.Controls 2.12
import bsh.backend 1.0

BaseScreen {
    id: root
    property string title
    property GenericListModel listModel
    property real scrollBarHeight: approximateInNativeResolution(2)
    property real scrollBarMargin: 11
    property real sideMargin: 25

    property real longPressDelay: 50

    property bool isInEditMode: false
    property bool isInDragMode: false
    property bool isDuplicateHovered: false

    contentExitScale: 1.2
    contentEntryScale: 0.8

    function cancelEditing() {
        isInEditMode = false
    }

    // Clicking anywhere outside an active area will cancel the edit mode
    onClicked: cancelEditing()

    header: Header {
        title: root.title
        hasBackButton: true
        hasEditButton: true
        editColor: isInEditMode ? constants.defaultBlue : themedStrongContrastColor
        editHandler: function(){ isInEditMode = !isInEditMode }
        hasSaveButton: isInEditMode
        saveHandler: cancelEditing
        runBackArrowAnimation: true
        backHandler: function() {
            if (isInEditMode) {
                modalOverlay.openURL("QuestionOverlay.qml", {
                                      "question": "Editieren abbrechen und zurück?",
                                      "cancelAnswer": "Nein",
                                      "actionAnswer": "Ja",
                                      "confirmCallback": function() { display.pop() }
                                      }, 618, 216, false)
            } else {
                display.pop()
            }
        }
    }
    
    content: Item {
        ListView {
            id: listView
            anchors.fill: parent
            anchors.leftMargin: sideMargin
            anchors.rightMargin: sideMargin
            anchors.bottomMargin: sideMargin
            clip: true
            height: headerItem.height
            spacing: approximateInNativeResolution(6)
            flickableDirection : Flickable.HorizontalFlick
            interactive: !isInDragMode

            ScrollBar.horizontal: ScrollBar {
                parent: listView.parent
                anchors.top: listView.bottom
                anchors.topMargin: 0.5 * (root.sideMargin - root.scrollBarHeight)
                anchors.left: listView.left
                anchors.right: listView.right
                height: root.scrollBarHeight
                padding: 0
                policy: (listView.width < listView.contentWidth) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                contentItem: Rectangle {
                    color: constants.scrollBarColor
                }
                background: null
            }

            header: Item {
                width: addFavoriteButton.width + listView.spacing
                height: addFavoriteButton.height
                ImageTileButton {
                    id: addFavoriteButton
                    width: constants.imageTileWidth
                    height: constants.imageTileHeight
                    textSize: constants.descriptionTextSize
                    textAreaHeight: 168
                    textBackgroundOpacity: 0
                    title: isInEditMode || isInDragMode ? qsTr("Hier hin ziehen\nzum Duplizieren") : qsTr("Favorit anlegen")
                    iconSource: isInEditMode || isInDragMode ? "file:resources/siemens/icons/icn_duplizieren.png" : "file:resources/siemens/icons/icn_favorite-add_plus.png"
                    backgroundColor: isInEditMode || isInDragMode ? "transparent" : "#1e232b"
                    onClicked: {
                        if (!isInEditMode) display.push("FavoriteBaseCoice.qml", {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/siemens/images/BIG_Kachel_Heizarten.png"})
                    }
                    TileEditBorder {
                        visible: isInEditMode || isInDragMode
                        color: isDuplicateHovered ? constants.defaultBlue : constants.settingsInactiveColor
                        useSolidLine: isDuplicateHovered
                    }
                }
            }

            orientation: Qt.Horizontal
            model: listModel
            delegate: Item {
                id: delegateRoot
                width: constants.imageTileWidth
                height: constants.imageTileHeight
                property real dragStartX
                property real dragStartY
                property real dragMouseStartX
                property real dragMouseStartY
                property bool dragDirectionDetermined
                property bool dragHorizontal
                property bool isDraggedItem: false
                property int originalIndex

                function startDrag() {
                    if (!isInDragMode) {
                        tile.parent = listView
                        tile.x = listView.mapFromItem(delegateRoot, 0, 0).x
                        originalIndex = index
                        isDraggedItem = true
                        isInDragMode = true
                        dragDirectionDetermined = false
                    }
                }

                function stopDrag() {
                    longPressTimer.stop()
                    dragPressTimer.stop()
                    if (isInDragMode) {
                        dragDirectionDetermined = false
                        isDuplicateHovered = false
                        tile.parent = delegateRoot
                        tile.x = 0
                        tile.y = 0
                        listView.returnToBounds()
                        isDraggedItem = false
                        isInDragMode = false
                    }
                }

                // Workaround for inconsistent and and overall bad qml mouse event control
                Timer {
                    id: longPressTimer
                    interval: root.longPressDelay
                    onTriggered: {
                        if (isInEditMode) startDrag()
                        else dragPressTimer.restart()
                    }
                }
                Timer {
                    id: dragPressTimer
                    interval: 500
                    onTriggered: startDrag()
                }

                // Edge Scroll
                property int scrollingDirection: 0
                NumberAnimation {
                    id: scrollBack
                    target: listView
                    property: "contentX"
                    to: listView.originX
                    duration: listView.count * 175
                    running: isDraggedItem && scrollingDirection === -1
                }
                NumberAnimation {
                    id: scrollForward
                    target: listView
                    property: "contentX"
                    to: listView.contentWidth + listView.originX - listView.width
                    duration: listView.count * 175
                    running: isDraggedItem && scrollingDirection === 1
                }

                FavoriteTileButton {
                    id: tile
                    property bool isSwipedOut: false

                    programDefinition: (index >= 0) ? listModel.get(index) : null
                    isLongPressed: dragPressTimer.running
                    width: constants.imageTileWidth
                    height: constants.imageTileHeight
                    scale: ((isInDragMode || isInEditMode) && !isDraggedItem)  ? 0.85 : 1.0
                    Behavior on scale {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.OutCubic
                        }
                    }

                    hasHorizontalDragIndicator: (isDraggedItem || isInEditMode) && (dragHorizontal || !dragDirectionDetermined)
                    hasVerticalDragIndicator: (isDraggedItem || isInEditMode) && (!dragHorizontal || !dragDirectionDetermined)
                    isStartEnabled: !(isInDragMode || isInEditMode)

                    property bool dragReleasing: false
                    onPressed: {
                        dragReleasing = false
                        dragMouseStartX = mouse.x
                        dragMouseStartY = mouse.y
                        dragHorizontal = true
                        dragStartX = listView.mapFromItem(tile, 0, 0).x - listView.mapFromItem(delegateRoot, 0, 0).x + mouse.x * scale
                        dragStartY = listView.mapFromItem(tile, 0, 0).y - listView.mapFromItem(delegateRoot, 0, 0).y + mouse.y * scale
                        longPressTimer.restart()
                    }

                    onPositionChanged: {
                        if (isDraggedItem) {
                            if (!dragDirectionDetermined) {
                                var deltaX = Math.abs(dragMouseStartX - mouse.x)
                                var deltaY = Math.abs(dragMouseStartY - mouse.y)
                                if (deltaX > 15 || deltaY > 15) {
                                    dragHorizontal = deltaX >= deltaY
                                    dragDirectionDetermined = true
                                }
                            }
                            if (dragDirectionDetermined) {
                                var relativePositionInListView = listView.mapFromItem(tile, 0, 0)
                                if (dragHorizontal) {
                                    var desiredX = relativePositionInListView.x + mouse.x * scale - dragStartX
                                    var xInListView = relativePositionInListView.x - tile.x
                                    tile.x = Math.min(listView.width - xInListView - tile.width + sideMargin, Math.max(-xInListView - sideMargin, desiredX))
                                } else {
                                    var desiredY = relativePositionInListView.y + mouse.y * scale - dragStartY
                                    tile.y = desiredY

                                    if (!isSwipedOut && Math.abs(tile.y) > 0.65 * tile.height) {
                                        tile.opacity = 0
                                        stopDrag();
                                        modalOverlay.openURL("QuestionOverlay.qml", {
                                                              "question": "Wollen sie diesen Favorit\nwirklich löschen?",
                                                              "cancelAnswer": "Abbrechen",
                                                              "actionAnswer": "Löschen",
                                                              "confirmCallback": function() { isSwipedOut = true; deleteFavoriteAnimation.start() }
                                                              }, 618, 216, false, function() { if (!tile.isSwipedOut) tile.opacity = 1})
                                    }
                                }
                            }
                        }
                    }

                    onCanceled: stopDrag()

                    onClicked: {
                        if (!isInEditMode && tile.opacity > 0) {
                            stopDrag()
                            if (!dragReleasing && programDefinition.bgImage) {
                                backend.setCurrentProgramFromDefinition(programDefinition)
                                display.push(programDefinition.isMeal ? "MealConfigScreen.qml" : "ProgramConfigScreen.qml")
                            }
                        }
                    }
                    onReleased: {
                        if (isDraggedItem) {
                            if (isDuplicateHovered) {
                                keyboardOverlay.readText(programDefinition.name + " (2)", function(newName) {
                                    //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                                    var programCopy = backend.getProgramDefinitionCopy(programDefinition)
                                    programCopy.name = newName
                                    programCopy.origin = programCopy
                                    listModel.move(index, delegateRoot.originalIndex)
                                    backend.favorites.insert(programCopy, 0)
                                })
                            }

                            dragReleasing = true
                        }
                        stopDrag()
                    }

                    onStart: {
                        stopDrag()
                        backend.setCurrentProgramFromDefinition(programDefinition)
                        display.push("RunningScreen.qml")
                    }

                    //TODO may be dangerous as concurrent executions might clash
                    // and the timer is a poor solution impeding fluidity
                    function evaluatePositionChange() {
                        if (isDraggedItem && !dragReleasing) {
                            var xCoord = listView.mapFromItem(tile, 0, 0).x
                            if (xCoord < 0) {
                                scrollingDirection = -1
                            } else if (xCoord > listView.width - tile.width) {
                                scrollingDirection = 1
                            } else {
                                scrollingDirection = 0
                            }

                            var centerX = listView.contentX + xCoord + 0.5 * tile.width
                            isDuplicateHovered = centerX < 0

                            var targetIndex = listView.indexAt(centerX,0)
                            if(targetIndex >= 0 && index !== targetIndex) {
                                listModel.move(index, targetIndex)
                            }
                        } else {
                            scrollingDirection = 0
                        }
                    }
                    Timer {
                        id: reEvaluationTimer
                        interval : 100
                        onTriggered: tile.evaluatePositionChange()
                    }
                    onXChanged: reEvaluationTimer.start()
                    Connections {
                        target: listView
                        onContentXChanged: reEvaluationTimer.start()
                    }

                    SequentialAnimation {
                        id: deleteFavoriteAnimation
                        NumberAnimation {
                            target: tile
                            property: "opacity"
                            to: 0
                            duration: 500
                            easing.type: Easing.OutCubic
                        }
                        ScriptAction {
                            script: listModel.remove(index)
                        }
                    }

                    onFavorite: {
                        stopDrag()
                        modalOverlay.openURL("QuestionOverlay.qml", {
                                              "question": "Wollen sie diesen Favorit\nwirklich löschen?",
                                              "cancelAnswer": "Abbrechen",
                                              "actionAnswer": "Löschen",
                                              "confirmCallback": function() { deleteFavoriteAnimation.start() }
                                              }, 618, 216, false)
                    }
                }
            }

            displaced: Transition {
                NumberAnimation {
                    property: "x"
                    easing.type: Easing.OutCubic
                    duration: 500
                }
            }
            rebound: Transition {
                NumberAnimation {
                    properties: "x"
                    duration: 600
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
