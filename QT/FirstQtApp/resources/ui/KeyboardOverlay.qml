import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.VirtualKeyboard 2.3
import bsh.eox6021 1.0

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
                live: false
                visible: false
            }
            GaussianSmoothing {
                id: blurredBackground
                anchors.fill: backgroundSource
                source: backgroundSource
                opacity: 0
                radius: 40

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
                    source: "file:resources/icons/close.png"
                    color: themedStrongContrastColor
                    onClicked: root.active = false
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
                    font.pixelSize: constants.smallTitleSize
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
