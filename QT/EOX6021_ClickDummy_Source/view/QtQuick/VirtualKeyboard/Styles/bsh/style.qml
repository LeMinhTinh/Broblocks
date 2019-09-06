import QtQuick 2.12
import QtQuick.VirtualKeyboard 2.3
import QtQuick.VirtualKeyboard.Styles 2.2

KeyboardStyle {
    id: currentStyle
    readonly property string fontFamily: clickDummy.font.family
    readonly property real keyBackgroundMargin: 13 * scaleHint
    readonly property real keySizeSmall: 57 * scaleHint
    readonly property real keySizeNormal: 78 * scaleHint
    readonly property real keySizeSymbolic: 66 * scaleHint
    readonly property real keyIconScale: 0.65 * scaleHint

    keyboardDesignWidth: 2560
    keyboardDesignHeight: 800

    keyPanel: KeyPanel {
        id: key
        Rectangle {
            id: keyBackground
            color: (control.text === "Speichern") ? constants.defaultBlue : "#1fffffff"
            anchors.fill: key
            anchors.margins: keyBackgroundMargin
            opacity: control.pressed ? 0.80 : 1.0
            Text {
                id: keySmallText
                text: control.smallText
                visible: control.smallTextVisible
                color: "gray"
                anchors.centerIn: keyBackground
                font {
                    pixelSize: keySizeSmall
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
            Text {
                id: keyText
                text: control.displayText
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: keyBackground
                font {
                    pixelSize: keySizeNormal
                    capitalization: control.uppercased ? Font.AllUppercase : Font.MixedCase
                }
            }
        }
    }

    backspaceKeyPanel: KeyPanel {
        id: backspaceKey
        Rectangle {
            id: backspaceKeyBackground
            color: "#1fffffff"
            anchors.fill: backspaceKey
            anchors.margins: keyBackgroundMargin
            opacity: control.pressed ? 0.80 : 1.0
            Image {
                id: backspaceKeyIcon
                anchors.centerIn: backspaceKeyBackground
                sourceSize.width: 159 * keyIconScale
                sourceSize.height: 88 * keyIconScale
                source: "file:resources/siemens/icons/keyboard_backspace.png"
            }
        }
    }

    shiftKeyPanel: KeyPanel {
        id: shiftKey
        Rectangle {
            id: shiftKeyBackground
            color: "#1fffffff"
            anchors.fill: shiftKey
            anchors.margins: keyBackgroundMargin
            opacity: control.pressed ? 0.80 : 1.0
            Image {
                id: shiftKeyIcon
                anchors.centerIn: shiftKeyBackground
                sourceSize.width: 144 * keyIconScale
                sourceSize.height: 134 * keyIconScale
                source: "file:resources/siemens/icons/" + (InputContext.capsLock ? "keyboard_shift_lock.png" : control.uppercased ? "keyboard_shift_on.png" : "keyboard_shift_off.png")
            }
        }
    }

    spaceKeyPanel: KeyPanel {
        id: spaceKey
        Rectangle {
            id: spaceKeyBackground
            color: "#1fffffff"
            anchors.fill: spaceKey
            anchors.margins: keyBackgroundMargin
            opacity: control.pressed ? 0.80 : 1.0
        }
    }

    symbolKeyPanel: KeyPanel {
        id: symbolKey
        Rectangle {
            id: symbolKeyBackground
            color: "#1fffffff"
            anchors.fill: symbolKey
            anchors.margins: keyBackgroundMargin
            opacity: control.pressed ? 0.80 : 1.0
            Text {
                id: symbolKeyText
                text: control.displayText
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.centerIn: symbolKeyBackground
                font {
                    pixelSize: keySizeSymbolic
                    capitalization: Font.AllUppercase
                }
            }
        }
    }
}
