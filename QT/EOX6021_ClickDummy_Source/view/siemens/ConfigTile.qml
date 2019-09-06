import QtQuick 2.12
import bsh.backend 1.0

TileButton {
    id: root

    readonly property int fadeInTime: 200
    readonly property int fadeOutTime: 200

    property string optionName
    property string optionIcon
    property bool isOptionDeactivated: false
    property bool isEdited: false
    property real openWidth: constants.openedConfigTileWidth

    property int positionInConfigScreen
    readonly property bool isInOverviewMode: state === "overview"
    property Item overview: Item {}
    onOverviewChanged: {
       overview.parent = root
    }
    property Item optionWindow: Item {}
    onOptionWindowChanged: {
        optionWindow.parent = root
        optionWindow.anchors.centerIn = root
    }

    Connections {
        target: overview
        onOpacityChanged: overview.visible = (overview.opacity != 0)
    }
    Connections {
        target: optionWindow
        onOpacityChanged: optionWindow.visible = (optionWindow.opacity != 0)
    }

    signal closeRequest()
    signal closing()
    signal closed()
    signal opening()
    signal opened()
    state: "overview"

    implicitWidth: constants.overviewTileWidth
    implicitHeight: constants.overviewTileHeight

    states: [
        State {
         name: "overview"
         PropertyChanges { target: root.overview; opacity: 1.0 }
         PropertyChanges { target: root.optionWindow; opacity: 0.0 }
         PropertyChanges { target: closeIcon; opacity: 0.0 }
        },
        State {
         name: "open"
         PropertyChanges { target: root; width: root.openWidth }
         PropertyChanges { target: root.overview; opacity: 0.0 }
         PropertyChanges { target: root.optionWindow; opacity: 1.0 }
         PropertyChanges { target: closeIcon; opacity: 1.0 }
        }
    ]
    transitions: [
        Transition {
            to: "open"
            SequentialAnimation {
                ScriptAction { script: opening() }
                ParallelAnimation {
                    NumberAnimation { target: root.overview; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root; properties: "width"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: closeIcon; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root.optionWindow; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                }
                ScriptAction { script: opened() }
            }
        },
        Transition {
            to: "overview"
            SequentialAnimation {
                ScriptAction { script: closing() }
                ParallelAnimation {
                    NumberAnimation { target: closeIcon; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root.optionWindow; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root; properties: "width"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root.overview; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                }
                ScriptAction { script: closed() }
            }
        }
    ]

    IconButton {
        id: closeIcon
        source: "file:resources/siemens/icons/icn_close.png"
        color: "#ffffff"
        anchors.top: parent.top
        anchors.right: parent.right
        width: implicitWidth + 40
        height: implicitHeight + 40
        onClicked: {
            root.closeRequest()
        }
        visible: !embedded
    }

    hasShine: true
    hasShadow: true
    TileEditBorder { visible: isEdited }
}
