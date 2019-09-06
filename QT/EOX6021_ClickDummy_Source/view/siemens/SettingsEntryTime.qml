import QtQuick 2.12
import bsh.backend 1.0

SettingsEntry {
    id: root

    Component {
        id: timeWheel

        Item {
            property string title: root.title

            ConfigTileTwoWheels {
                id: wheel
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 100
                anchors.verticalCenter: parent.verticalCenter
                embedded: true
                state: "open"
                separator: ":"
                isCircular: true

                isOptionDeactivated: false
                optionEnabled: true
                currentEnabled: true
                onReset: {
                    backend.wallClock = 0
                }

                function setByNumpad(value, enabled) {
                    var timeValue = 3600 * Math.min(23, Math.floor(value / 100)) + 60 * Math.min(59, (value % 100))
                    backend.wallClock = timeValue
                }
                property Item numpadPanel
                numpadFunction: function () {
                    numpadPanel = modalOverlay.openURL("NumpadPanel.qml", {"optionIcon": optionIcon, "optionName": optionName, "value": getMinutes(backend.wallClock) + getHours(backend.wallClock) * 100 , "separator": " : ",
                                         "units": [primaryOptionUnit, secondaryOptionUnit], "unitOnTop": unitOnTop, "isEnabled": optionEnabled, "hasReset": true, "confirmCallback": setByNumpad, "maxDigits": [2, 2]},
                                         1088, 462)
                }

                function createHourOptions() {
                    var stringList = []
                    for (var i = 0; i < 24; ++i) {
                        stringList.push(i.toString())
                    }
                    return stringList
                }
                primaryOption: createHourOptions()
                primaryPeriodOfWheelLabel: 2

                function createMinuteOptions() {
                    var stringList = []
                    for (var i = 0; i < 60; ++i) {
                        stringList.push(i.toString())
                    }
                    return stringList
                }
                secondaryOption: createMinuteOptions()
                secondaryPeriodOfWheelLabel: 5

                function updateOptionIndices() {
                    primaryOptionIndex= getHours(backend.wallClock)
                    secondaryOptionIndex= getMinutes(backend.wallClock)
                }
                Component.onCompleted: {
                    updateOptionIndices()
                }

                Connections {
                    target: backend
                    onWallClockChanged: wheel.updateOptionIndices()
                }

                function updateTime() {
                    var newClock = 60 * (currentPrimaryIndex * 60 + currentSecondaryIndex)
                    if (backend.wallClock !== newClock) backend.wallClock = newClock
                }
                onCurrentPrimaryIndexChanged: if (currentPrimaryIndex !== primaryOptionIndex) updateTime()
                onCurrentSecondaryIndexChanged: if (currentSecondaryIndex !== secondaryOptionIndex) updateTime()
            }

            BSHCheckBox {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                anchors.horizontalCenter: parent.horizontalCenter
                label: "Auto"
                labelColor: themedStrongContrastColor
                checked: false
                spacing: 30
            }
        }
    }

    onClicked: settingsStack.push(timeWheel)

    TextLabel {
        anchors.right: entryArrow.left
        anchors.rightMargin: 42
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: animationProgress * constants.textSizeF1
        color: constants.settingsInactiveColor
        text: getHhMmFromSeconds(backend.wallClock)
    }

    Icon {
        id: entryArrow
        anchors.right: root.right
        anchors.rightMargin: 27
        anchors.verticalCenter: root.verticalCenter
        height: animationProgress * implicitHeight
        source:  "file:resources/siemens/icons/settings_arrow.png"
        color: themedStrongContrastColor
    }
}
