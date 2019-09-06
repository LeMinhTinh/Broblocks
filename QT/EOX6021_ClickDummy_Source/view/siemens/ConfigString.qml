import QtQuick 2.12
import QtQuick.Layouts 1.12

RowLayout {
    property real textSize: constants.textSizeF10
    property real iconMargin: 20
    property string value
    property string valueSecondary
    property string unit
    property string unitSecondary
    property string separatorString
    property string iconSource
    property bool unitOnTop: true
    property bool iconBottomAligned: false
    property color iconColor
    property color valueColor

    spacing: 0
    Icon {
        id: iconpic
        source: iconSource
        color: iconColor
        visible: iconSource
        Layout.alignment: (iconBottomAligned ? Qt.AlignBottom : Qt.AlignVCenter) | Qt.AlignLeft
        Layout.rightMargin: value ? iconMargin : 0
    }
    RowLayout {
        id: valueString
        spacing: 0
        Layout.alignment: (iconBottomAligned ? Qt.AlignBottom : Qt.AlignVCenter) | Qt.AlignLeft

        TextLabel {
            id: valueLabel
            fontPixelSize: textSize
            color: valueColor
            text: value
            maximumLineCount: 2
            visible: value
        }
        TextLabel {
            id: unitLabel
            Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
            fontPixelSize: 0.5 * valueLabel.fontPixelSize
            color: valueColor
            text: unit
            visible: unit
        }

        TextLabel {
            id: separatorStringLabel
            fontPixelSize: textSize
            color: valueColor
            text: separatorString
            visible: separatorString
        }

        TextLabel {
            id: valueLabelSecondary
            fontPixelSize: textSize
            color: valueColor
            text: valueSecondary
            maximumLineCount: 2
            visible: valueSecondary
        }
        TextLabel {
            id: unitLabelSecondary
            Layout.alignment: unitOnTop ? Qt.AlignTop : Qt.AlignBottom
            fontPixelSize: 0.5 * valueLabelSecondary.fontPixelSize
            color: valueColor
            text: unitSecondary
            visible: unitSecondary
        }
    }
}
