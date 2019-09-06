import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtGraphicalEffects 1.0
import bsh.eox6021 1.0

Item {
    id: root
    property string optionIcon
    property string optionName

    property var options
    property string optionUnit
    property bool unitOnTop
    property int optionIndex
    property bool optionEnabled
    property bool isOptionDeactivated: false

    property bool useSliderColoring: true
    property bool hasEnableButton: true
    property bool isEnabled: optionEnabled
    property int currentIndex: optionIndex

    property bool hasManualOption: false
    property alias manualChecked: manualCheckBox.checked

    readonly property int sliderHeight: 120
    readonly property int normalSliderBlockHeight: 11
    readonly property int sliderBaseSpacing: 6
    readonly property int pressedSliderBlockHeight: 15
    readonly property int horizontalMinimumMargin: 40
    readonly property int maximumBarWidth: 137
    readonly property int enableButtonSliderMargin: 35
    readonly property int checkboxMargin: 30
    readonly property int numberOffEnableButtons: hasEnableButton ? 1 : 0
    readonly property color gradientStartColor: "#006fd3"
    readonly property color gradientStopColor: "#28bbff"

    property real barWidth: Math.min(maximumBarWidth, (width - numberOffEnableButtons * enableButtonSliderMargin - 2 * horizontalMinimumMargin - (options.length - 1) * sliderBaseSpacing) / (options.length + numberOffEnableButtons))
    property real horizontalMargin: (parent.width - (options.length + numberOffEnableButtons) * barWidth - (options.length - 1) * sliderBaseSpacing - numberOffEnableButtons * enableButtonSliderMargin) / 2
    property real gradientWidth: options.length * barWidth + (options.length - 1) * sliderBaseSpacing
    property real sliderWidth: parent.width - 2 * horizontalMargin
    property real sliderEnableEnd: numberOffEnableButtons * barWidth / sliderWidth
    property real sliderOptionValueStart: numberOffEnableButtons * (barWidth + enableButtonSliderMargin) / sliderWidth - 0.5 * sliderBaseSpacing / sliderWidth
    property real sliderOptionValueRange: 1.0 - sliderOptionValueStart + sliderBaseSpacing / sliderWidth

    function setSliderValue() {
        slider.value = optionEnabled ? (sliderOptionValueStart + sliderOptionValueRange * (optionIndex + 0.5) / options.length) : 0
    }
    Component.onCompleted: {
        setSliderValue()
    }
    onOptionIndexChanged: {
        if(optionIndex != currentIndex) {
            currentIndex = optionIndex
            setSliderValue()
        }
    }
    onOptionEnabledChanged: {
        if(optionEnabled != isEnabled) {
            isEnabled = optionEnabled
            setSliderValue()
        }
    }

    Slider {
        id: slider
        width: sliderWidth
        height: sliderHeight
        anchors.left: parent.left
        anchors.leftMargin: horizontalMargin
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: hasManualOption ? -checkboxMargin : 0

        onVisualPositionChanged: {
            root.currentIndex = Math.max(0, Math.min(options.length * (slider.visualPosition - sliderOptionValueStart ) / sliderOptionValueRange, options.length - 1))
            root.isEnabled = root.isEnabled ? (slider.visualPosition > sliderEnableEnd) : (slider.visualPosition > sliderOptionValueStart)
        }

        handle: null
        background: Item {
            id: sliderBackground

            Item {
                id: sliderBarAssets
                width: gradientWidth
                height: pressedSliderBlockHeight
                visible: false

                LinearGradient {
                    id: sliderGradient
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(width, 0)
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: gradientStartColor }
                        GradientStop { position: 1.0; color: gradientStopColor }
                    }
                    cached: true
                }
                Rectangle {
                    id: sliderInactive
                    anchors.fill: parent
                    color: constants.inactiveColor
                }
            }

            Item {
                id: enableButtonUnit
                visible: hasEnableButton
                width: barWidth
                height: parent.height
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left

                TextLabel {
                    anchors.horizontalCenter: enabledButtonBlock.horizontalCenter
                    anchors.bottom: parent.verticalCenter
                    anchors.bottomMargin: 20 + 0.5 * normalSliderBlockHeight
                    fontPixelSize: constants.descriptionTextSize
                    color: root.isOptionDeactivated ? constants.inactiveColor : root.isEnabled ? themedLightContrastColor : constants.highlightBlue
                    text: "out"
                }

                Rectangle {
                    id: enabledButtonBlock
                    height: normalSliderBlockHeight
                    width: parent.width
                    color: root.isOptionDeactivated || root.isEnabled ? constants.inactiveColor : gradientStartColor
                    anchors.verticalCenter: parent.verticalCenter

                    states: State {
                        when: slider.pressed
                        PropertyChanges {
                            target: enabledButtonBlock
                            height: pressedSliderBlockHeight
                        }
                    }
                    transitions: Transition {
                        NumberAnimation { properties: "height"; easing.type: Easing.OutCubic; duration: 120 }
                    }
                }
            }

            Row {
                id: sliderBase
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: hasEnableButton ? enableButtonUnit.right : parent.left
                anchors.leftMargin: hasEnableButton ? enableButtonSliderMargin : 0
                anchors.right: parent.right
                spacing: sliderBaseSpacing

                Repeater {
                    model: options.length
                    Item {
                        id: sliderUnit
                        width: barWidth
                        height: parent.height
                        RowLayout {
                            anchors.bottom: parent.verticalCenter
                            anchors.bottomMargin: 20 + 0.5 * normalSliderBlockHeight
                            anchors.horizontalCenter: parent.horizontalCenter
                            spacing: 0
                            property color textColor: root.isOptionDeactivated ? constants.inactiveColor : (root.isEnabled && root.currentIndex == index) ? constants.highlightBlue : themedLightContrastColor
                            TextLabel {
                                id: optionValueLabel
                                Layout.maximumWidth: sliderUnit.width - optionUnitLabel.width
                                fontPixelSize: constants.descriptionTextSize
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

                        ShaderEffectSource {
                            id: sliderBlock
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: normalSliderBlockHeight
                            sourceRect: Qt.rect(parent.x, 0, width, height)
                            sourceItem: (root.isEnabled && !root.isOptionDeactivated && root.currentIndex >= index && (root.currentIndex <= index || useSliderColoring)) ? sliderGradient : sliderInactive

                            states: State {
                                when: slider.pressed
                                PropertyChanges {
                                    target: sliderBlock
                                    height: pressedSliderBlockHeight
                                }
                            }
                            transitions: Transition {
                                NumberAnimation { properties: "height"; easing.type: Easing.OutCubic; duration: 120 }
                            }
                        }
                    }
                }
            }
        }
    }

    Icon {
        id: descriptionIcon
        anchors.verticalCenter: descriptionText.verticalCenter
        anchors.right: descriptionText.left
        anchors.rightMargin: 20
        source: root.optionIcon
        color: themedLightContrastColor
    }

    TextLabel {
        id: descriptionText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 0.5 * (descriptionIcon.width + descriptionIcon.anchors.rightMargin)
        anchors.baseline: parent.bottom
        anchors.baselineOffset: -40
        fontPixelSize: constants.descriptionTextSize
        color: themedLightContrastColor
        text: optionName
    }

    BSHCheckBox {
        id: manualCheckBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: descriptionText.top
        anchors.bottomMargin: checkboxMargin
        visible: hasManualOption
        label: "manually"
        labelColor: themedStrongContrastColor
    }
}
