import QtQuick 2.12
import QtQuick.Controls 2.12
import bsh.backend 1.0

Loader {
    id: root

    z: 99
    anchors.fill: parent
    active: false
    sourceComponent: active ? overlay : null

    function show() {
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

            Image {
                id: blurredBackground
                source: "file:resources/siemens/images/Settings_Background.png"
                opacity: 0
            }
            /*ShaderEffectSource {
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
                sigma: 40
                opacity: 0

                Rectangle {
                    id: shroud
                    anchors.fill: parent
                    opacity: 0.7
                    color: "#000000"
               }
               Component.onCompleted: grabToImage(function(result) {
                   result.saveToFile("Settings_Background.png");
               })
            }*/

            SequentialAnimation {
                id: intoAnimation
                running: true
                property real animationTime: 300


                PauseAnimation {
                    duration: 50
                }
                ParallelAnimation {
                    NumberAnimation {
                        targets: [blurredBackground, titleLabel, closeButton, backButton]
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: intoAnimation.animationTime
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: header
                        property: "opacity"
                        from: 0
                        to: 0.08
                        duration: intoAnimation.animationTime
                        easing.type: Easing.OutQuad
                    }
                    NumberAnimation {
                        target: closeButton
                        property: "rotation"
                        to: 90
                        duration: intoAnimation.animationTime
                        easing.type: Easing.OutQuad
                    }
                }
            }


            Rectangle {
                id: header
                anchors.top: parent.top
                height: 96
                width: parent.width
                opacity: 0.0
                color: "#ffffff"
            }
            IconButton {
                id: backButton
                anchors.verticalCenter: header.verticalCenter
                anchors.horizontalCenter: header.left
                anchors.horizontalCenterOffset: 60
                width: 94
                height: 94
                visible: settingsStack.depth > 1
                source: "file:resources/siemens/icons/icn_back.png"
                color: themedStrongContrastColor
                onClicked: settingsStack.pop()
                opacity: 0
            }
            TextLabel {
                id: titleLabel
                anchors.top: parent.top
                anchors.topMargin: 36
                anchors.horizontalCenter: parent.horizontalCenter
                fontPixelSize: constants.textSizeF4
                color: constants.settingsInactiveColor
                text: settingsStack.currentItem.title
                opacity: 0
            }
            IconButton {
                id: closeButton
                anchors.right: parent.right
                anchors.top: parent.top
                source: "file:resources/siemens/icons/settings_close.png"
                color: themedStrongContrastColor
                onClicked: root.active = false
                width: 96
                height: 96
                rotation: 45
                opacity: 0
            }


            Item {
                id: content
                anchors.fill: parent
                anchors.topMargin: 96

                Rectangle {
                    id: titleDivider
                    width: parent.width
                    height: approximateInNativeResolution(1)
                    color: "#000000"
                }

                SettingsModel {
                    id: settingsModel
                }
                StackView {
                    id: settingsStack
                    anchors.top: titleDivider.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    clip: true
                    Component.onCompleted: push("SettingsMenu.qml", {"model": settingsModel.mainCategoryModel, "title": "Settings", "runEntryAnimation": true})
                }
            }
        }
    }
}
