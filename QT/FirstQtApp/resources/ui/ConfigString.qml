import QtQuick 2.11
import QtQuick.Layouts 1.11

RowLayout {
    property real textSize: constants.optionTileTextSize
    property real iconMargin: 20
    property string value
    property string valueSecondary
    property string unit
    property string unitSecondary
    property string seperatorString
    property string iconSource
    property bool unitOnTop: true
    property color iconColor
    property color valueColor

    spacing: iconMargin
    Icon {
        id: iconpic
        source: iconSource
        color: iconColor
    }
    RowLayout {
        id: valueString
        spacing: 0

        TextLabel {
            id: valueLabel
            fontPixelSize: textSize
            color: valueColor
            text: value
            maximumLineCount: 2
            lineSpacing: 0.5 * textSize
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
            id: seperatorStringLabel
            fontPixelSize: textSize
            color: valueColor
            text: seperatorString
            visible: seperatorString
        }

        TextLabel {
            id: valueLabelSecondary
            fontPixelSize: textSize
            color: valueColor
            text: valueSecondary
            maximumLineCount: 2
            lineSpacing: 0.5 * textSize
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
