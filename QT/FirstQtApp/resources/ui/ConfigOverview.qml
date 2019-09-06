import QtQuick 2.11
import bsh.eox6021 1.0

Item {
    id: root
    property string optionName
    property bool isEnabled: true
    property bool isDeactivated: false

    property string value
    property string valueSecondary
    property string unit
    property string unitSecondary
    property string seperatorString
    property string iconSource
    property bool unitOnTop: true
    property color iconColor: isDeactivated ? constants.inactiveColor : (isEnabled ? constants.defaultBlue : themedStrongContrastColor)
    property color valueColor: isDeactivated ? constants.inactiveColor : themedStrongContrastColor

    ConfigString {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 75

        value: root.value
        valueSecondary: root.valueSecondary
        unit: root.unit
        unitSecondary: root.unitSecondary
        seperatorString: root.seperatorString
        iconSource: root.iconSource
        unitOnTop: root.unitOnTop
        iconColor: root.iconColor
        valueColor: root.valueColor
    }

    TextLabel {
       anchors.left: parent.left
       anchors.leftMargin: 5
       anchors.right: parent.right
       anchors.rightMargin: anchors.leftMargin
       anchors.baseline: parent.bottom
       anchors.baselineOffset: -40
       fontPixelSize: constants.descriptionTextSize
       lineSpacing: 0.35 * fontPixelSize
       maximumLineCount: 2
       color: themedLightContrastColor
       text: parent.optionName
       doElide: true
       horizontalAlignment: Text.AlignHCenter
       visible: lineCount < 2
    }

    TextLabel {
       anchors.left: parent.left
       anchors.leftMargin: 5
       anchors.right: parent.right
       anchors.rightMargin: anchors.leftMargin
       anchors.verticalCenter: parent.bottom
       anchors.verticalCenterOffset: -40-0.5*fontPixelSize+0.5*lineSpacing
       fontPixelSize: constants.descriptionTextSize
       lineSpacing: 0.35 * fontPixelSize
       maximumLineCount: 2
       color: themedLightContrastColor
       text: parent.optionName
       doElide: true
       horizontalAlignment: Text.AlignHCenter
       visible: lineCount > 1
    }
}
