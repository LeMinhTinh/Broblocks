import QtQuick 2.11
import bsh.eox6021 1.0

Loader {
    id: root
    property string question
    property string cancelAnswer
    property string actionAnswer
    property var confirmCallback: function() {}
    signal cancel()
    signal action()

    z: 99
    anchors.fill: parent
    active: false
    sourceComponent: active ? overlay : null

    function confirm(question, cancelAnswer, actionAnswer, confirmCallback)
    {
        root.question = question
        root.cancelAnswer = cancelAnswer
        root.actionAnswer = actionAnswer
        root.confirmCallback = confirmCallback
        active = true
    }

    Component {
        id: overlay

        MouseArea {
            anchors.fill: parent

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
                    target: shroud
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: questionBox
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

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
            }
            Rectangle {
                id: shroud
                opacity: 0
                anchors.fill: parent
                color: "#8f000000"
            }

            Rectangle {
                id: questionBox
                anchors.horizontalCenter: parent.horizontalCenter
                y: 96
                width: 670
                height: 322
                opacity: 0
                color: "#1fffffff"

                TileShadow {}

                TextLabel {
                    id: questionLabel
                    anchors.horizontalCenter: parent.horizontalCenter
                    y: 81 - 3.2 * mm
                    width: 0.9 * parent.width
                    horizontalAlignment: Text.AlignHCenter

                    fontPixelSize: 32
                    color: constants.blueThemeLightContrast
                    text: root.question
                    maximumLineCount: 2
                    lineSpacing: 2.8 * mm
                }

                FooterButton {
                    id: cancelButton
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 43
                        left: parent.left
                        leftMargin: 43
                    }
                    width: 0.5 * (parent.width - 91)
                    height: 11.2 * mm
                    fontColor: "#ffffff"
                    color: "#26ffffff"
                    text: root.cancelAnswer
                    onClicked: {
                        cancel()
                        root.active = false
                    }
                }

                FooterButton {
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: 43
                        right: parent.right
                        rightMargin: 43
                    }
                    width: 0.5 * (parent.width - 91)
                    height: 11.2 * mm
                    fontColor: "#ffffff"
                    color: constants.defaultBlue
                    text: root.actionAnswer
                    onClicked: {
                        root.confirmCallback()
                        action()
                        root.active = false
                    }
                }
            }
        }
    }
}
