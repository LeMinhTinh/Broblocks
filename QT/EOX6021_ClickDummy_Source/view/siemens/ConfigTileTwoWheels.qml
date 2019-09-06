import QtQuick 2.12
import QtQuick.Layouts 1.12

ConfigTile {
    id: root

    // Common
    property string optionName: ""
    property string optionIcon
    property bool unitOnTop
    property bool isCircular
    property bool optionEnabled
    property string separator
    property int flashingDuration: 750
    property bool hasNumpad: true
    property var numpadFunction: function() {}
    property real overviewIconMargin: 20
    property bool showControlDescription: true

    // Data for primary and secondary option
    property var primaryOption
    property var primaryOptionIndex
    property string primaryOptionUnit: ""
    property int primaryNumOfSideBars: 7
    property int primaryPeriodOfWheelLabel

    property var secondaryOption
    property var secondaryOptionIndex
    property string secondaryOptionUnit: ""
    property int secondaryNumOfSideBars: 7
    property int secondaryPeriodOfWheelLabel

    // For propagating
    property int currentPrimaryIndex: primaryOptionIndex
    property int currentSecondaryIndex: secondaryOptionIndex
    property bool currentEnabled: optionEnabled

    // Variables for handling the two wheels
    property bool primary: false
    property string currentValue: currentEnabled ? primaryOption[currentPrimaryIndex].length > 1 ? primaryOption[currentPrimaryIndex] : "0" + primaryOption[currentPrimaryIndex] : "--"
    property string currentSecondaryValue: currentEnabled ? secondaryOption[currentSecondaryIndex].length > 1 ? secondaryOption[currentSecondaryIndex] : "0" + secondaryOption[currentSecondaryIndex] : "--"

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
        iconMargin: root.overviewIconMargin
        unitOnTop: root.unitOnTop
        separatorString: root.separator
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: Loader {
        clip: true
        active: visible
        anchors.fill:parent
        sourceComponent: Item {
            id: optionWindow
            anchors.fill:parent

            property Animation primaryPulse: SequentialAnimation {
                running: primary && root.state === "open"
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
                running: !primary && root.state === "open"
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
                showOptionDescription: root.showControlDescription
                Binding { target: root; property: "currentPrimaryIndex"; value: primaryWheel.currentOptionIndex }
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
                showOptionDescription: root.showControlDescription
                Binding { target: root; property: "currentSecondaryIndex"; value: secondaryWheel.currentOptionIndex }
            }

            IconButton {
                id: numpadButton
                visible: hasNumpad
                anchors.bottom: textLabels.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: -190
                touchWidth: 96
                touchHeight: 96
                source: "file:resources/siemens/icons/icn_numpad.png"
                color: themedStrongContrastColor
                onClicked: numpadFunction()
            }

            RowLayout {
                id: textLabels
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0

                TextLabel {
                    id: primaryValueLabel
                    fontPixelSize: constants.runningBigConfigTextSize
                    text: currentValue
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
                property alias separatorLabel: separatorLabel
                TextLabel {
                    id: separatorLabel
                    fontPixelSize: primaryValueLabel.fontPixelSize
                    color: themedStrongContrastColor
                    text: root.separator
                }
                TextLabel {
                    id: secondaryValueLabel
                    fontPixelSize: primaryValueLabel.fontPixelSize
                    text: currentSecondaryValue
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

            MouseArea{
                anchors.top: parent.top
                height: 95
                anchors.left: numpadButton.right
                anchors.leftMargin: 28
                anchors.right: textLabels.horizontalCenter
                anchors.rightMargin: 0.5 * textLabels.width - textLabels.separatorLabel.x - 0.5 * textLabels.separatorLabel.width
                onClicked: primary = true
            }
            MouseArea{
                anchors.top: parent.top
                height: 95
                anchors.left: textLabels.horizontalCenter
                anchors.leftMargin: textLabels.separatorLabel.x + 0.5 * textLabels.separatorLabel.width - 0.5 * textLabels.width
                anchors.right: resetButton.left
                anchors.rightMargin: 28
                onClicked: primary = false
            }

            IconButton {
                id: resetButton
                source: "file:resources/siemens/icons/Reset.png"
                color: themedStrongContrastColor
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.horizontalCenterOffset: 190
                touchWidth: 96
                touchHeight: 96
                anchors.bottom: textLabels.bottom

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
}
