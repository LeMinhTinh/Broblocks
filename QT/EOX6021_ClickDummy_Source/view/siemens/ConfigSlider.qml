import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import bsh.backend 1.0

Item {
    id: root
    // core parameters
    property string optionIcon
    property string optionName
    property var options
    property string optionUnit
    property int optionIndex
    property bool optionEnabled: true
    property bool isOptionDeactivated: false

    // layout parameters
    property bool unitOnTop: false
    property bool showOptionDescription: true
    property bool focusValueMode: false
    property bool hasOffPosition: false
    property bool hasManualOption: false
    property real sliderHeight: 120
    property real normalSliderBlockHeight: 11
    property real sliderBaseSpacing: approximateInNativeResolution(6)
    property real pressedSliderBlockHeight: 15
    property real horizontalMinimumMargin: 40
    property real maximumBarWidth: 137
    property real offPostionMargin: 35
    property real checkboxMargin: 30
    property string checkBoxLabel: "manuell"
    property string offPositionLabel: "aus"
    property real textCenterToSliderOffset: hasManualOption ? -30 : -42

    // feedback variables
    property bool isEnabled: optionEnabled
    property int currentIndex: optionIndex
    onOptionIndexChanged: {
        if(optionIndex != currentIndex) {
            currentIndex = optionIndex
        }
    }
    onOptionEnabledChanged: {
        if(optionEnabled != isEnabled) {
            isEnabled = optionEnabled
        }
    }
    property alias manualChecked: manualCheckBox.checked

    // internal variables
    readonly property real barWidth: Math.min(maximumBarWidth, (width - (hasOffPosition ? offPostionMargin : 0)  - 2 * horizontalMinimumMargin - (options.length - 1) * sliderBaseSpacing) / (options.length + (hasOffPosition ? 1 : 0)))
    readonly property real horizontalMargin: (width - (options.length + (hasOffPosition ? 1 : 0)) * barWidth - (options.length - 1) * sliderBaseSpacing - (hasOffPosition ? offPostionMargin : 0)) / 2
    readonly property real sliderWidth: width - 2 * horizontalMargin
    readonly property real sliderEnableEnd: hasOffPosition ? barWidth / sliderWidth : 0
    readonly property real sliderOptionValueStart: (hasOffPosition ? (barWidth + offPostionMargin) / sliderWidth : 0) - 0.5 * sliderBaseSpacing / sliderWidth
    readonly property real sliderOptionValueRange: 1.0 - sliderOptionValueStart + sliderBaseSpacing / sliderWidth

    Slider {
        id: slider
        width: sliderWidth
        height: sliderHeight
        anchors.left: parent.left
        anchors.leftMargin: horizontalMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: hasManualOption ? -checkboxMargin : 0

        value: optionEnabled ? (sliderOptionValueStart + sliderOptionValueRange * (optionIndex + 0.5) / options.length) : 0

        onVisualPositionChanged: {
            root.currentIndex = Math.max(0, Math.min(options.length * (slider.visualPosition - sliderOptionValueStart ) / sliderOptionValueRange, options.length - 1))
            root.isEnabled = root.isEnabled ? (slider.visualPosition > sliderEnableEnd) : (slider.visualPosition > sliderOptionValueStart)
        }
        onPressedChanged: {
            if (pressed && hasManualOption) manualCheckBox.checked = false
        }

        handle: null
        background: Item {
            id: sliderBackground

            Item {
                id: offPositionUnit
                visible: hasOffPosition
                width: barWidth
                height: parent.height
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left

                TextLabel {
                    anchors.horizontalCenter: enabledButtonBlock.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.verticalCenterOffset: textCenterToSliderOffset - 0.5 * normalSliderBlockHeight
                    horizontalAlignment: Text.AlignHCenter
                    fontPixelSize: constants.textSizeF1
                    color: root.isOptionDeactivated ? constants.inactiveColor : root.isEnabled ? themedLightContrastColor : constants.highlightBlue
                    text: offPositionLabel
                }

                Rectangle {
                    id: enabledButtonBlock
                    // not using verticalCenter anchor here is important for proper animation
                    y: 0.5 * (parent.height - height)
                    height: slider.pressed ? pressedSliderBlockHeight : normalSliderBlockHeight
                    width: parent.width
                    color: root.isOptionDeactivated || root.isEnabled ? constants.inactiveColor : constants.defaultBlue

                    Behavior on height {
                        NumberAnimation {
                            easing.type: Easing.OutCubic
                            duration: 120
                        }
                    }
                }
            }

            Row {
                visible: focusValueMode
                anchors.bottom: parent.verticalCenter
                anchors.bottomMargin: 45 + 0.5 * normalSliderBlockHeight
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 0
                TextLabel {
                    id: focusValueLabel
                    fontPixelSize: constants.textSizeF5
                    color: constants.defaultBlue
                    text: options[currentIndex]
                    maximumLineCount: 1
                    horizontalAlignment: Text.AlignHCenter
                }
                TextLabel {
                    id: focusUnitLabel
                    anchors.bottom: unitOnTop ? undefined : focusValueLabel.bottom
                    anchors.top: unitOnTop ? focusValueLabel.top : undefined
                    fontPixelSize: 0.5 * focusValueLabel.fontPixelSize
                    color: constants.defaultBlue
                    text: optionUnit
                    visible: optionUnit
                }
            }

            Row {
                id: sliderBase
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: hasOffPosition ? offPositionUnit.right : parent.left
                anchors.leftMargin: hasOffPosition ? offPostionMargin : 0
                anchors.right: parent.right
                spacing: sliderBaseSpacing

                Repeater {
                    model: options.length
                    Item {
                        id: sliderUnit
                        width: barWidth
                        height: parent.height

                        RowLayout {
                            visible: focusValueMode ? (index === 0 || index === options.length -1) : true
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: textCenterToSliderOffset - 0.5 * normalSliderBlockHeight
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 0
                            property color textColor: focusValueMode ? themedStrongContrastColor : root.isOptionDeactivated ? constants.inactiveColor : (root.isEnabled && root.currentIndex == index) ? constants.defaultBlue : themedLightContrastColor
                            TextLabel {
                                id: optionValueLabel
                                Layout.maximumWidth: sliderUnit.width - optionUnitLabel.width
                                fontPixelSize: constants.textSizeF1
                                horizontalAlignment: Text.AlignHCenter
                                color: parent.textColor
                                text: options[index]
                                maximumLineCount: 2
                            }
                            TextLabel {
                                id: optionUnitLabel
                                Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
                                fontPixelSize: 0.5 * optionValueLabel.fontPixelSize
                                color: parent.textColor
                                text: optionUnit
                                visible: optionUnit
                            }
                        }

                        Rectangle {
                            id: sliderBlock
                            // not using verticalCenter anchor here is important for proper animation
                            y: 0.5 * (parent.height - height)
                            width: parent.width
                            height: slider.pressed ? pressedSliderBlockHeight : normalSliderBlockHeight
                            color: (root.isEnabled && !root.isOptionDeactivated && root.currentIndex >= index && (root.currentIndex <= index)) ? constants.defaultBlue : constants.inactiveColor

                            Behavior on height {
                                NumberAnimation {
                                    easing.type: Easing.OutCubic
                                    duration: 120
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Row {
        id: optionNameLabel
        visible: showOptionDescription
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: root.bottom
        anchors.verticalCenterOffset: -52
        spacing: 20

        Icon {
            anchors.verticalCenter: parent.verticalCenter
            source: root.optionIcon
            color: themedLightContrastColor
        }

        TextLabel {
            anchors.verticalCenter: parent.verticalCenter
            fontPixelSize: constants.textSizeF1
            color: themedLightContrastColor
            text: root.optionName
        }
    }

    BSHCheckBox {
        id: manualCheckBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: optionNameLabel.top
        anchors.bottomMargin: checkboxMargin
        visible: hasManualOption
        label: checkBoxLabel
        labelColor: themedStrongContrastColor
    }
}
