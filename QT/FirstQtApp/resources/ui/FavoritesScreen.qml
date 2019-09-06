import QtQuick 2.11
import QtQuick.Controls 2.4
import bsh.eox6021 1.0

BaseScreen {
    id: root
    property string title
    property GenericListModel listModel
    property real scrollBarHeight: 4
    property real scrollBarMargin: 12
    property real defaultSpacing: 6
    property real screenEdgeMargin: 25

    property int defaultTileWidth: 303
    property int defaultTileHeight: 424

    property real longPressDelay: 50

    property bool isInEditMode: false
    property bool isInDragMode: false
    property bool isDuplicateHovered: false

    contentEntryScale: 0.8

    function cancelEditing() {
        isInEditMode = false
    }

    // Clicking anywhere outside an active area will cancel the edit mode
    onClicked: cancelEditing()

    header: Header {
        title: root.title
        hasBackButton: !isInEditMode
        hasEditButton: true
        editColor: isInEditMode ? constants.defaultBlue : themedStrongContrastColor
        editHandler: function(){ isInEditMode = !isInEditMode }
        hasSaveButton: isInEditMode
        saveColor: constants.defaultBlue
        saveHandler: cancelEditing
        runAnimation: false
    }

    content: ListView {
        id: listView
        anchors.leftMargin: screenEdgeMargin
        anchors.rightMargin: screenEdgeMargin
        height: headerItem.height + scrollBarMargin + 0.5 * scrollBarHeight
        spacing: defaultSpacing
        flickableDirection : Flickable.HorizontalFlick
        interactive: !isInDragMode

        ScrollBar.horizontal: ScrollBar {
            height: scrollBarHeight
            policy: (listView.width < listView.contentWidth) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            contentItem: Rectangle {
                color: "#4e5665"
            }
            background: Rectangle {
                color: "#000000"
            }
        }

        header: Item {
            width: addFavoriteButton.width + listView.spacing
            height: addFavoriteButton.height
            ImageTileButton {
                id: addFavoriteButton
                width: defaultTileWidth
                height: defaultTileHeight
                textSize: constants.descriptionTextSize
                textAreaHeight: 168
                title: isInEditMode || isInDragMode ? qsTr("Move to here\nzum copy") : qsTr("Favorit anlegen")
                iconSource: isInEditMode || isInDragMode ? "file:resources/icons/icn_duplizieren.png" : "file:resources/icons/icn_favorite-add_plus.png"
                backgroundColor: isInEditMode || isInDragMode ? "transparent" : "#333333"
                onClicked: {
                    if (!isInEditMode) display.push("FavoriteBaseCoice.qml", {title: title, listModel: backend.ovenPrograms, backgroundSource: "file:resources/images/img_BG_heizarten.png"})
                }
                TileEditBorder {
                    visible: isInEditMode || isInDragMode
                    color: isDuplicateHovered ? constants.defaultBlue : constants.inactiveColor
                    useSolidLine: isDuplicateHovered
                }
            }
        }

        orientation: Qt.Horizontal
        model: listModel
        delegate: Item {
            id: delegateRoot
            width: defaultTileWidth
            height: defaultTileHeight
            property real dragStartX
            property bool isDraggedItem: false

            function startDrag() {
                if (!isInDragMode) {
                    tile.parent = listView
                    tile.x = listView.mapFromItem(delegateRoot, 0, 0).x
                    isDraggedItem = true
                    isInDragMode = true
                }
            }

            function stopDrag() {
                longPressTimer.stop()
                dragPressTimer.stop()
                if (isInDragMode) {
                    isDuplicateHovered = false
                    tile.parent = delegateRoot
                    tile.x = 0
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
                programDefinition: (index >= 0) ? listModel.get(index) : null
                isLongPressed: dragPressTimer.running
                width: defaultTileWidth
                height: defaultTileHeight
                scale: ((isInDragMode || isInEditMode) && !isDraggedItem)  ? 0.8 : 1.0
                Behavior on scale {
                    NumberAnimation {
                        duration: 70
                        easing.type: Easing.OutCubic
                    }
                }

                y: isInDragMode || isInEditMode ? (0.5 * buttonImage.implicitHeight - 0.5 * height) : 0

                hasDragIndicator: isDraggedItem || isInEditMode
                isStartEnabled: !(isInDragMode || isInEditMode)

                property bool dragReleasing: false
                onPressed: {
                    dragReleasing = false
                    dragStartX = listView.mapFromItem(tile, 0, 0).x - listView.mapFromItem(delegateRoot, 0, 0).x + mouse.x * scale
                    longPressTimer.restart()
                }

                onPositionChanged: {
                    if (isDraggedItem) {
                        var relativeXInListView = listView.mapFromItem(tile, 0, 0).x
                        var desiredX = relativeXInListView + mouse.x * scale - dragStartX
                        var xInListView = relativeXInListView - tile.x
                        tile.x = Math.min(listView.width - xInListView - tile.width + screenEdgeMargin, Math.max(-xInListView - screenEdgeMargin, desiredX))
                    }
                }

                onCanceled: stopDrag()

                onClicked: {
                    if (!isInEditMode) {
                        stopDrag()
                        if (!dragReleasing && programDefinition.bgImage) {
                            backend.setCurrentProgramFromDefinition(programDefinition)
                            display.push("ProgramConfigScreen.qml")
                        }
                    }
                }
                onReleased: {
                    if (isDraggedItem) {
                        if (isDuplicateHovered) {
                            keyboardOverlay.readText(programDefinition.name + " (2)", function(newName) {
                                cancelEditing()
                                //Create and insert a copy as favorite in order not disturb any active backend operations on programDefinition
                                var programCopy = backend.getProgramDefinitionCopy(programDefinition)
                                programCopy.name = newName
                                programCopy.origin = programCopy
                                backend.favorites.insert(programCopy, 0)
                            })
                        }

                        dragReleasing = true
                    }
                    stopDrag()
                }

                onStart: {
                    stopDrag()
                    if (programDefinition.runningVideo) {
                        backend.setCurrentProgramFromDefinition(programDefinition)
                        display.push("RunningScreen.qml")
                    }
                }

                property bool evaluating: false
                function evaluatePositionChange() {
                    if (isDraggedItem) {
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

                onXChanged: {evaluatePositionChange()}

                Connections {
                    target: listView
                    onContentXChanged: tile.evaluatePositionChange()
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
                    questionOverlay.confirm("Do you want\n\"" + programDefinition.name + "\" delete?", "Abort", "delete", function() { deleteFavoriteAnimation.start() })
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
