import QtQuick 2.11

Loader {
    id: root

    readonly property var dummyFunction: function() {}
    property Component content: null
    property bool hasTimer: false
    property int closeTimeout: 1500
    property int boxWidth
    property int boxHeight
    property var closeCallback: dummyFunction
    property bool hasCloseButton: true

    z: 99
    anchors.fill: parent
    active: false
    onActiveChanged: if (!active) content = null
    sourceComponent: active ? overlay : null

    function open(content, closeCallback, hasTimer, width, height) {
        root.content = content
        root.closeCallback = (closeCallback === undefined) ? dummyFunction : closeCallback
        root.hasTimer = (hasTimer === undefined) ? false : hasTimer
        root.boxWidth = (width === undefined) ? 940 : width
        root.boxHeight = (height === undefined) ? 410 : height
        active = true
    }

    signal requestClose()
    function close() {
        requestClose()
    }

    Component {
        id: overlay

        MouseArea {
            id: overlayArea
            opacity: 0

            Connections {
                target: root
                onRequestClose: close.start()
            }

            anchors.fill: parent
            preventStealing: true

            Timer {
                id: closeTimer
                running: root.hasTimer
                interval: closeTimeout
                onTriggered: close.start()
            }

            onClicked: close.start()

            ParallelAnimation {
                running: true
                NumberAnimation {
                    target: overlayArea
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            SequentialAnimation {
                id: close
                NumberAnimation {
                    target: overlayArea
                    property: "opacity"
                    to: 0
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                ScriptAction {
                    script: closeCallback()
                }
                PropertyAction {
                    target: root
                    property: "active"
                    value: false
                }
            }

            ShaderEffectSource {
                id: backgroundSource
                anchors.centerIn: parent
                width: root.boxWidth
                height: root.boxHeight
                sourceRect: Qt.rect(x, y, width, height)
                sourceItem: display
                recursive: true
                live: false
                visible: false
            }
            GaussianSmoothing {
                id: blurredBackground
                anchors.fill: backgroundSource
                source: backgroundSource
                radius: 20
            }

            Rectangle {
                id: shroud
                anchors.fill: parent
                color: "#000000"
                opacity: 0.8
            }

            Rectangle {
                id: popUpColor
                anchors.fill: blurredBackground
                color: "#96b0d6"
                opacity: 0.2
            }

            Loader {
                id: contentLoader
                sourceComponent: content
                active: true
                anchors.centerIn: blurredBackground
            }

            IconButton {
                id: closeIcon
                anchors.top: blurredBackground.top
                anchors.topMargin: 20
                anchors.right: blurredBackground.right
                anchors.rightMargin: 20
                source: "file:resources/icons/close.png"
                color: "white"
                onClicked: close.start()
                visible: root.hasCloseButton
            }
        }
    }
}
