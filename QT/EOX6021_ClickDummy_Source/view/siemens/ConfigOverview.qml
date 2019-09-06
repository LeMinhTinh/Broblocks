import QtQuick 2.12
import bsh.backend 1.0

Item {
    id: root
    property string optionName
    property bool isEnabled: true
    property bool isDeactivated: false

    property string value
    property string valueSecondary
    property string unit
    property string unitSecondary
    property string separatorString
    property string iconSource
    property real iconMargin: 20
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
        separatorString: root.separatorString
        iconSource: root.iconSource
        iconMargin: root.iconMargin
        unitOnTop: root.unitOnTop
        iconColor: root.iconColor
        valueColor: root.valueColor
    }

    TextLabel {
       anchors.left: parent.left
       anchors.leftMargin: 5
       anchors.right: parent.right
       anchors.rightMargin: anchors.leftMargin
       anchors.verticalCenter: parent.bottom
       anchors.verticalCenterOffset: -52
       fontPixelSize: constants.textSizeF1
       maximumLineCount: 3
       color: themedLightContrastColor
       text: parent.optionName
       doElide: true
       horizontalAlignment: Text.AlignHCenter
    }
}
