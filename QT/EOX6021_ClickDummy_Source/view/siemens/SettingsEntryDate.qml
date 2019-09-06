import QtQuick 2.12
import bsh.backend 1.0

SettingsEntry {
    id: root

    property date currentDate: new Date()

    Component {
        id: numpadComponent

        Item {
            property string title: root.title

            NumpadPanel {
                id: numpad
                anchors.fill: parent
                units: ["", "", ""]
                maxDigits: [2, 2, 4]
                confirmCallback: function(value, enabled) {
                    var day = Math.floor(value / 1000000)
                    var month = Math.floor(value / 10000) % 100
                    var year = value % 10000
                    var newDate = new Date(year, month - 1, day)
                    root.currentDate = isFinite(newDate) ? newDate : new Date()
                    settingsStack.pop()
                }
                separator: "."
                extraLeftMargin: 230
                resetToValue: true
                value: currentDate.getDate() * 1000000 + (currentDate.getMonth() + 1) * 10000 + currentDate.getFullYear()
            }
        }
    }

    onClicked: settingsStack.push(numpadComponent)

    TextLabel {
        anchors.right: entryArrow.left
        anchors.rightMargin: 42
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: animationProgress * constants.textSizeF1
        color: constants.settingsInactiveColor
        text: currentDate.toLocaleDateString(Qt.locale(), "dd.MM.yyyy")
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
