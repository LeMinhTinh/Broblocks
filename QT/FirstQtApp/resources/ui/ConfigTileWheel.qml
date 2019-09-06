import QtQuick 2.11
import QtQuick.Layouts 1.11

ConfigTile {
    id: root
    property var options
    property int optionIndex
    property string optionUnit
    property string optionName
    property string optionIcon
    property int numOfSideBars
    property bool unitOnTop: true
    property bool isCircular: true
    property bool optionEnabled
    property int periodOfWheelLabel
    property string currentValue: options[optionIndex]
    property bool hasReset: true

    property int currentIndex: wheelWindow.currentOptionIndex
    property bool currentEnabled: wheelWindow.isEnabled

    signal reset();

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: root.currentValue
        unit: root.optionUnit
        iconSource: root.optionIcon
        unitOnTop: root.unitOnTop
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: Item {
        id: optionWondow
        anchors.fill: parent

        ConfigWheel {
            id: wheelWindow
            width: parent.width
            height: parent.height
            numberOfVisibleSideBars: root.numOfSideBars
            isCircular: root.isCircular
            optionIcon: root.optionIcon
            optionName: root.optionName
            periodOfWheelLabel: root.periodOfWheelLabel

            options: root.options
            optionIndex: root.optionIndex
            optionEnabled: root.optionEnabled
            isOptionDeactivated: root.isOptionDeactivated
        }

        // CurrentValue above Wheel
        RowLayout {
            id: valueLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: unit.width/2
            anchors.baseline: wheelWindow.top
            anchors.baselineOffset: 36
            spacing: 0

            TextLabel {
                id: value
                text: wheelWindow.isEnabled ? wheelWindow.options[wheelWindow.currentOptionIndex] : "--:--"
                color: wheelWindow.isOptionDeactivated ? constants.inactiveColor : constants.highlightBlue
                fontPixelSize: 64
            }
            TextLabel {
                id: unit
                visible: root.optionUnit
                Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
                text: root.optionUnit
                fontPixelSize: 0.5 * value.fontPixelSize
                color: wheelWindow.isOptionDeactivated ? constants.inactiveColor : constants.highlightBlue
            }
        }

        IconButton {
            id: resetButton
            visible: hasReset
            anchors.left: valueLabel.right
            anchors.leftMargin: 30
            anchors.top: valueLabel.top
            source: "file:resources/icons/Reset.png"
            color: themedStrongContrastColor
            onClicked: {
                wheelWindow.spin.stop()
                wheelWindow.moveToCenter.stop()
                reset()
            }

        }
    }
}
