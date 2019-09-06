import QtQuick 2.11
import QtQuick.Layouts 1.11

ConfigTile {
    id: root

    // Common
    property var optionName
    property string optionIcon
    property bool unitOnTop
    property bool isCircular
    property bool optionEnabled
    property string seperator
    property int flashingDuration: 750

    // Data for primary and secondary option
    property var primaryOption
    property var primaryOptionIndex
    property var primaryOptionUnit
    property var primaryNumOfSideBars
    property int primaryPeriodOfWheelLabel
    property real primaryPercentageOfSeperator: 0.05

    property var secondaryOption
    property var secondaryOptionIndex
    property var secondaryOptionUnit
    property var secondaryNumOfSideBars
    property int secondaryPeriodOfWheelLabel
    property real secondaryPercentageOfSeperator: 0.05

    // For propagating
    property int currentPrimaryIndex: primaryWheel.currentOptionIndex
    property int currentSecondaryIndex: secondaryWheel.currentOptionIndex
    property bool currentEnabled

    // Variables for handling the two wheels
    property bool primary: false
    property string currentValue: currentEnabled ? primaryOption[currentPrimaryIndex].length > 1 ? primaryOption[currentPrimaryIndex] : "0" + primaryOption[currentPrimaryIndex] : "--"
    property string currentSecondaryValue: currentEnabled ? secondaryOption[currentSecondaryIndex].length > 1 ? secondaryOption[currentSecondaryIndex] : "0" + secondaryOption[currentSecondaryIndex] : "--"

    property Animation primaryPulse: SequentialAnimation {
        running: primary && state === "open"
        onStarted: {
            primaryValueLabel.color = constants.defaultBlue
            secondaryValueLabel.color = themedStrongContrastColor
        }
        NumberAnimation {
            id: primaryAnimation
            target: primaryValueLabel
            property: "opacity"
            from: 1
            to: 0.2
            duration: flashingDuration
            easing.type: Easing.InSine
        }
        NumberAnimation {
            target: primaryValueLabel
            property: "opacity"
            to: 1
            duration: primaryAnimation.duration
            easing.type: Easing.OutSine
        }
        onStopped: primaryValueLabel.opacity = 1
        loops: Animation.Infinite
    }

    property Animation secondaryPulse: SequentialAnimation {
        running: !primary && state === "open"
        onStarted: {
            secondaryValueLabel.color = constants.defaultBlue
            primaryValueLabel.color = themedStrongContrastColor
        }
        NumberAnimation {
            id: secondaryAnimation
            target: secondaryValueLabel
            property: "opacity"
            from: 1
            to: 0.2
            duration: flashingDuration
            easing.type: Easing.InSine
        }
        NumberAnimation {
            target: secondaryValueLabel
            property: "opacity"
            to: 1
            duration: primaryAnimation.duration
            easing.type: Easing.OutSine
        }
        onStopped: secondaryValueLabel.opacity = 1
        loops: Animation.Infinite
    }

    signal reset();

    onClosed: primary = false

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: root.currentValue
        valueSecondary: root.currentSecondaryValue
        unit: root.primaryOptionUnit
        unitSecondary: root.secondaryOptionUnit
        iconSource: root.optionIcon
        unitOnTop: root.unitOnTop
        seperatorString: root.seperator
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: Item {
        id: optionWindow
        anchors.fill:parent

        ConfigWheel {
            id: primaryWheel
            width: parent.width
            height: parent.height
            numberOfVisibleSideBars: root.primaryNumOfSideBars
            isCircular: root.isCircular
            optionIcon: root.optionIcon
            optionName: root.optionName

            options: root.primaryOption
            optionIndex: root.primaryOptionIndex
            optionEnabled: root.optionEnabled
            visible: primary
            periodOfWheelLabel: primaryPeriodOfWheelLabel
            percentageOfSeperator: primaryPercentageOfSeperator
        }

        ConfigWheel {
            id: secondaryWheel
            width: parent.width
            height: parent.height
            numberOfVisibleSideBars: root.secondaryNumOfSideBars
            isCircular: root.isCircular
            optionIcon: root.optionIcon
            optionName: root.optionName

            options: root.secondaryOption
            optionIndex: root.secondaryOptionIndex
            optionEnabled: root.optionEnabled
            visible: !primary
            periodOfWheelLabel: secondaryPeriodOfWheelLabel
            percentageOfSeperator: secondaryPercentageOfSeperator
        }

        RowLayout {
            id: textLabels
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 0

            TextLabel {
                id: primaryValueLabel
                fontPixelSize: constants.optionTileTextSize
                text: currentValue
                MouseArea{
                    anchors.fill: parent
                    onClicked: primary = true
                }
            }
            TextLabel {
                id: primaryOptionUnitLabel
                Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
                fontPixelSize: 0.5 * primaryValueLabel.fontPixelSize
                color: primaryValueLabel.color
                text: root.primaryOptionUnit
                visible: root.primaryOptionUnit
                opacity: primaryValueLabel.opacity
            }
            TextLabel {
                id: seperatorLabel
                fontPixelSize: primaryValueLabel.fontPixelSize
                color: themedStrongContrastColor
                text: root.seperator
            }
            TextLabel {
                id: secondaryValueLabel
                fontPixelSize: primaryValueLabel.fontPixelSize
                text: currentSecondaryValue
                MouseArea{
                    anchors.fill: parent
                    onClicked: primary = false
                }
            }
            TextLabel {
                id: secondaryOptionUnitLabel
                Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
                fontPixelSize: 0.5 * primaryValueLabel.fontPixelSize
                color: secondaryValueLabel.color
                text: root.secondaryOptionUnit
                visible: root.secondaryOptionUnit
                opacity: secondaryValueLabel.opacity
            }
        } // end Text-Row

        IconButton {
            id: resetButton
            source: "file:resources/icons/Reset.png"
            color: themedStrongContrastColor
            anchors.left: textLabels.right
            anchors.leftMargin: 30
            anchors.top: textLabels.top

            onClicked: {
                primaryWheel.spin.stop()
                primaryWheel.moveToCenter.stop()
                secondaryWheel.spin.stop()
                secondaryWheel.moveToCenter.stop()
                reset();
            }

        }

    } // end optionWindow


}
