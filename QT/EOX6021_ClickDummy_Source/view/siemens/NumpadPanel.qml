import QtQuick 2.12

Item {
    id: root
    property string optionIcon
    property string optionName
    property int value
    property var units
    property bool unitOnTop: true
    property bool isReset: false
    property bool hasReset: true
    property var confirmCallback: function(value, enabled) {}
    property var maxDigits: [3]
    property string paddingCharacter: maxDigits.length > 1 ? "0" : " "
    property int overallMaxDigits: {
        var sum = 0;
        for ( var i = 0; i < maxDigits.length; ++i) {
          sum += maxDigits[i];
        }
        return sum
    }
    property real valueFontPixelSize: 58.55
    property string separator: ""
    property real extraLeftMargin: 0.5 * (height - numpad.height)

    property bool resetToValue: false
    property int resetValue: value
    Component.onCompleted: resetValue = resetValue

    property bool initialEdit: true
    readonly property string valueString: (isReset && !resetToValue) ? "–".repeat(overallMaxDigits) : value.toString()
    readonly property int digits: valueString.length

    function toDigitInputString(value) {
        return paddingCharacter.repeat(overallMaxDigits - digits) + valueString
    }
    readonly property string inputString: toDigitInputString(value)

    Numpad {
        id: numpad
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: extraLeftMargin

        onBackspace: {
            if (initialEdit || isReset) {
                value = 0
                isReset = false
                initialEdit = false
            } else if (digits > 0) {
                value /= 10
            }
        }
        onNumber: {
            if (initialEdit || isReset) {
                value = number
                isReset = false
                initialEdit = false
            } else if (digits < overallMaxDigits) {
                value *= 10
                value += number
            }
        }
    }

    Item {
        anchors.top: numpad.top
        anchors.bottom: numpad.bottom
        anchors.horizontalCenter: numpad.right
        anchors.horizontalCenterOffset: 350
        width: Math.max(optionNameLabel.width, valueRow.width, button.width)

        Row {
            id: optionNameLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            spacing: 20

            Icon {
                id: icon
                source: root.optionIcon
                color: themedLightContrastColor
                visible: root.optionIcon
            }

            TextLabel {
                anchors.verticalCenter: icon.verticalCenter
                fontPixelSize: constants.textSizeF1
                color: themedLightContrastColor
                text: root.optionName
                visible: root.optionName
            }
        }

        Row {
            id: valueRow
            spacing: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -28
            Row {
                id: valueWithUnitLabel
                spacing: 0
                Repeater {
                    model: maxDigits.length
                    Row {
                        spacing: 0
                        Repeater {
                            id: subValue
                            property int outerIndex: index
                            model: maxDigits[index]
                            TextLabel {
                                width: 33
                                text: {
                                    var index_base = 0;
                                    for ( var i = 0; i < subValue.outerIndex; ++i) {
                                        index_base += maxDigits[i];
                                    }
                                    return root.inputString[index_base + index]
                                }
                                color: constants.highlightBlue
                                fontPixelSize: root.valueFontPixelSize
                            }
                        }
                        TextLabel {
                            visible: text
                            anchors.top: root.unitOnTop ? parent.top : undefined
                            anchors.bottom: root.unitOnTop ? undefined: parent.bottom
                            text: root.units[index]
                            fontPixelSize: 0.5 * root.valueFontPixelSize
                            color: constants.highlightBlue
                        }
                        TextLabel {
                            visible: text && index < maxDigits.length - 1
                            anchors.top: root.unitOnTop ? parent.top : undefined
                            anchors.bottom: root.unitOnTop ? undefined: parent.bottom
                            text: root.separator
                            fontPixelSize: root.valueFontPixelSize
                            color: constants.highlightBlue
                        }
                    }
                }
            }
            IconButton {
                id: resetButton
                visible: root.hasReset
                touchWidth: 96
                touchHeight: 96
                anchors.verticalCenter: valueWithUnitLabel.verticalCenter
                source: "file:resources/siemens/icons/Reset.png"
                color: themedStrongContrastColor
                onClicked: {
                    if (resetToValue) value = resetValue
                    root.isReset = true
                }
            }
        }

        FooterButton {
            id: button
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            text: "Übernehmen"
            onClicked: {
                root.confirmCallback(value, !isReset)
                modalOverlay.terminate()
            }
        }
    }
}
