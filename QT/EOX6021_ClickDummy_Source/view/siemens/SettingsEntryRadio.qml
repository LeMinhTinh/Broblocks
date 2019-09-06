import QtQuick 2.12
import bsh.backend 1.0

SettingsEntry {
    id: root
    property ProgramStringOption option
    property string description

    Component {
        id: radioControl

        Item {
            property string title: root.title

            TextLabel {
                id: descriptionLabel
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 73
                fontPixelSize: constants.textSizeF1
                color: constants.settingsInactiveColor
                text: root.description
                horizontalAlignment: Text.AlignHCenter
            }

            Row {
                anchors.top: descriptionLabel.bottom
                anchors.topMargin: 67
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 96
                Repeater {
                    model: option.options.length
                    delegate: MouseArea {
                        width: selection.width + 40
                        height: selection.height + 40
                        onClicked: option.currentIndex = index
                        Row {
                            id: selection
                            anchors.centerIn: parent
                            spacing: 10
                            Icon {
                                anchors.verticalCenter: parent.verticalCenter
                                source: "file:resources/siemens/icons/radio_button.png"
                                color: themedStrongContrastColor
                                Icon {
                                    anchors.centerIn: parent
                                    visible: index === option.currentIndex
                                    source: "file:resources/siemens/icons/radio_button_filling.png"
                                    color: constants.defaultBlue
                                }
                            }
                            TextLabel {
                                anchors.verticalCenter: parent.verticalCenter
                                fontPixelSize: constants.textSizeF1
                                color: themedStrongContrastColor
                                text: option.options[index]
                            }
                        }
                    }
                }
            }
        }
    }

    onClicked: settingsStack.push(radioControl)

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
