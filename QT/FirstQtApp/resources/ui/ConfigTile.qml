import QtQuick 2.11
import bsh.eox6021 1.0


//配置选项tile

TileButton {
    id: root

    readonly property int fadeInTime: 200
    readonly property int fadeOutTime: 200

    property string optionName
    property string optionIcon
    property bool isOptionDeactivated: false
    property bool isEdited: false

    property int positionInConfigScreen
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

    implicitWidth: 274
    implicitHeight: 260

    states: [
        State {
         name: "overview"
         PropertyChanges { target: root; width: 274 }
         PropertyChanges { target: root.overview; opacity: 1.0 }
         PropertyChanges { target: root.optionWindow; opacity: 0.0 }
         PropertyChanges { target: closeIcon; opacity: 0.0 }
        },
        State {
         name: "open"
         PropertyChanges { target: root; width: 772 }
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
                    NumberAnimation {target: root.overview; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                    NumberAnimation { target: root; properties: "width"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    SequentialAnimation {
                        ParallelAnimation {
                            NumberAnimation { target: closeIcon; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                            NumberAnimation { target: root.optionWindow; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                        }
                    }
                }
                ScriptAction { script: opened() }
            }
        },
        Transition {
            to: "overview"
            SequentialAnimation {
                ScriptAction { script: closing() }
                ParallelAnimation {
                    ParallelAnimation {
                         NumberAnimation { target: closeIcon; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                         NumberAnimation { target: root.optionWindow; properties: "opacity"; duration: fadeOutTime; easing.type: Easing.OutCubic }
                    }
                    NumberAnimation { target: root; properties: "width"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    SequentialAnimation {
                        NumberAnimation { target: root.overview; properties: "opacity"; duration: fadeInTime; easing.type: Easing.OutCubic }
                    }
                }
                ScriptAction { script: closed() }
            }
        }
    ]

    IconButton {
        id: closeIcon
        source: "file:resources/icons/close.png"
        color: "#ffffff"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        width: 30
        height: 30
        onClicked: {
            root.closeRequest()
        }
        visible: !embedded
    }

    TileShine { visible: !embedded && !isEdited }
    TileEditBorder { visible: isEdited }
}
