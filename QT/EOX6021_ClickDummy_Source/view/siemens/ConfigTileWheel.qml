import QtQuick 2.12
import QtQuick.Layouts 1.12

ConfigTile {
    id: root
    property var options
    property int optionIndex
    property string optionUnit
    property string optionName
    property string optionIcon
    property int numOfSideBars: 7
    property bool unitOnTop: true
    property bool isCircular: true
    property bool optionEnabled
    property int periodOfWheelLabel
    property string currentValue: optionEnabled ? options[optionIndex] : disabledValueLabel
    property bool hasReset: true
    property string disabledValueLabel: "aus"
    property string overviewDisabledValueLabel
    property bool showUnitForDisabledValue: false
    property bool showOverviewUnitForDisabledValue: showUnitForDisabledValue
    property bool hasNumpad: true
    property var numpadFunction: function() {}
    property real overviewIconMargin: 20
    property string referenceValue
    property bool showControlDescription: true

    property int currentIndex: optionIndex
    property bool currentEnabled: optionEnabled

    signal reset();

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: optionEnabled || !overviewDisabledValueLabel ? currentValue : overviewDisabledValueLabel
        unit: root.optionEnabled || showOverviewUnitForDisabledValue ? root.optionUnit : ""
        iconSource: root.optionIcon
        iconMargin: root.overviewIconMargin
        unitOnTop: root.unitOnTop
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: Loader {
        clip: true
        active: visible
        anchors.fill:parent
        sourceComponent: Item {
            id: optionWondow
            anchors.fill: parent

            ConfigWheel {
                id: wheel
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
                showOptionDescription: root.showControlDescription

                Binding { target: root; property: "currentIndex"; value: wheel.currentOptionIndex }
                Binding { target: root; property: "currentEnabled"; value: wheel.isEnabled }
            }

            IconButton {
                id: numpadButton
                visible: hasNumpad
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -190
                anchors.bottom: focusValue.bottom
                touchWidth: 96
                touchHeight: 96
                source: "file:resources/siemens/icons/icn_numpad.png"
                color: themedStrongContrastColor
                onClicked: numpadFunction()
            }


            // CurrentValue above Wheel
            Row {
                spacing: 0
                id: focusValue
                anchors.top: wheel.top
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 0.5 * width - (root.referenceValue ? (referenceValueDivider.x + 0.5 * referenceValueDivider.width) : (valueLabel.x + 0.5 * valueLabel.width))

                TextLabel {
                    id: referenceValueLabel
                    fontPixelSize: valueLabel.fontPixelSize
                    color: themedLightContrastColor
                    text: root.referenceValue
                    visible: root.referenceValue
                }
                TextLabel {
                    id: referenceUnitLabel
                    anchors.bottom: !unitOnTop ? referenceValueLabel.bottom : undefined
                    anchors.top: unitOnTop ? referenceValueLabel.top : undefined
                    fontPixelSize: 0.5 * referenceValueLabel.fontPixelSize
                    color: themedLightContrastColor
                    text: root.optionUnit
                    visible: root.referenceValue
                }
                TextLabel {
                    id: referenceValueDivider
                    fontPixelSize: valueLabel.fontPixelSize
                    color: themedLightContrastColor
                    text: " / "
                    visible: root.referenceValue
                }

                TextLabel {
                    id: valueLabel
                    text: wheel.isEnabled ? wheel.options[wheel.currentOptionIndex] : root.disabledValueLabel
                    color: wheel.isOptionDeactivated ? constants.inactiveColor : constants.highlightBlue
                    fontPixelSize: 60.5
                }
                TextLabel {
                    id: unitLabel
                    visible: text
                    anchors.top: unitOnTop ? valueLabel.top : undefined
                    anchors.bottom: unitOnTop ? undefined: valueLabel.bottom
                    text: root.currentEnabled || showUnitForDisabledValue ? root.optionUnit : ""
                    fontPixelSize: 0.5 * valueLabel.fontPixelSize
                    color: wheel.isOptionDeactivated ? constants.inactiveColor : constants.highlightBlue
                }
            }

            IconButton {
                id: resetButton
                visible: hasReset
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 190
                touchWidth: 96
                touchHeight: 96
                anchors.bottom: focusValue.bottom
                source: "file:resources/siemens/icons/Reset.png"
                color: themedStrongContrastColor
                onClicked: {
                    wheel.spin.stop()
                    wheel.moveToCenter.stop()
                    reset()
                }
            }
        }
    }
}
