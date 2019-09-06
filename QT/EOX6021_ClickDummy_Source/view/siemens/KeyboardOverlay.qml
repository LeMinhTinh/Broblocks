import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.VirtualKeyboard 2.4
import bsh.backend 1.0

Loader {
    id: root
    property string initialText
    property var callback: function(output) {}

    z: 99
    anchors.fill: parent
    active: false
    sourceComponent: active ? overlay : null

    function readText(initialText, callback)
    {
        root.initialText = initialText
        root.callback = callback
        active = true
    }
    function terminate() {
        active = false
    }

    Component {
        id: overlay

        MouseArea {
            id: overlayMouseArea
            anchors.fill: parent

            ShaderEffectSource {
                id: backgroundSource
                anchors.fill: parent
                sourceRect: Qt.rect(x, y, width, height)
                sourceItem: display
                recursive: true
                live: true
                visible: false
            }
            GaussianSmoothing {
                id: blurredBackground
                anchors.fill: backgroundSource
                source: backgroundSource
                opacity: 0
                sigma: 40

                Rectangle {
                    id: shroud
                    anchors.fill: parent
                    color: "#8f000000"
                }
            }
            ParallelAnimation {
                id: intoAnimation
                running: true
                NumberAnimation {
                    target: blurredBackground
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: keyboardInput
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            FocusScope {
                id: keyboardInput
                anchors.centerIn: parent
                width: parent.width - 6 * mm
                height: parent.height - 6 * mm
                opacity: 0

                IconButton {
                    id: closeButton
                    anchors.right: parent.right
                    anchors.rightMargin: 3 * mm
                    anchors.top: keyboardInputField.top
                    source: "file:resources/siemens/icons/icn_close.png"
                    color: themedStrongContrastColor
                    onClicked: root.active = false
                    touchWidth: 96
                    touchHeight: 96
                }

                TextInput {
                    id: keyboardInputField
                    anchors.top: parent.top
                    anchors.topMargin: 3.0 * mm
                    anchors.bottom: virtualKeyboard.top
                    anchors.bottomMargin: 3.0 * mm
                    anchors.left: parent.left
                    anchors.leftMargin: 3 * mm
                    anchors.right: closeButton.left
                    anchors.rightMargin: 1 * mm
                    font.pixelSize: constants.textSizeF6
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    focus: true
                    color: themedLightContrastColor
                    text: root.initialText
                    inputMethodHints: Qt.ImhNoPredictiveText
                    selectionColor: "#555555"
                    // TODO For some reason Text selection handles are missaligned when allowing selection
                    selectByMouse: true
                    onActiveFocusChanged: {
                        if (activeFocus) {
                            selectAll()
                        }
                    }
                    Keys.onReleased: {
                        if (event.key === Qt.Key_Return) {
                            root.callback(text)
                            root.active = false
                        }
                    }
                }

                Rectangle {
                    id: dividerLine
                    anchors.bottom: keyboardInputField.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 2 * mm
                    anchors.right: parent.right
                    anchors.rightMargin: 2 * mm
                    color: themedLightContrastColor
                    height: 2
                }

                InputPanel {
                    id: virtualKeyboard
                    anchors.bottom: parent.bottom
                    width: parent.width
                }
            }

            Component.onCompleted: keyboardInputField.forceActiveFocus()
        }
    }
}
