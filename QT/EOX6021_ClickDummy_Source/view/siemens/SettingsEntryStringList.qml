import QtQuick 2.12
import bsh.backend 1.0

SettingsEntry {
    id: root
    property ProgramStringOption option

    Component {
        id: slider

        Item {
            property string title: root.title

            ConfigSlider {
                id: sliderTile
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                maximumBarWidth: 170

                options: option.options
                optionIndex: option.currentIndex
                isOptionDeactivated: false
                optionEnabled: true
                showOptionDescription: false

                onCurrentIndexChanged: {
                    if(option.currentIndex != currentIndex) option.currentIndex = currentIndex
                }
            }
        }
    }

    onClicked: settingsStack.push(slider)

    TextLabel {
        anchors.right: entryArrow.left
        anchors.rightMargin: 42
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.textSizeF1
        color: constants.settingsInactiveColor
        text: option.options[option.currentIndex]
    }

    Icon {
        id: entryArrow
        anchors.right: root.right
        anchors.rightMargin: 27
        anchors.verticalCenter: root.verticalCenter
        source:  "file:resources/siemens/icons/settings_arrow.png"
        color: themedStrongContrastColor
    }
}
