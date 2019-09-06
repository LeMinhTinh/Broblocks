import QtQuick 2.11
import QtQuick.Layouts 1.11

ConfigTile {
    id: root
    property var options
    property int optionIndex
    property string optionUnit
    property bool optionEnabled
    property bool unitOnTop: false
    property int currentIndex: sliderWindow.currentIndex
    property bool currentEnabled: sliderWindow.isEnabled
    property bool useSliderColoring: true
    property alias slider: sliderWindow
    property bool hasManualOption: false
    property alias manualChecked: sliderWindow.manualChecked

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: manualChecked ? "manually" : (root.optionEnabled ? options[optionIndex] : "out")
        unit: root.optionEnabled ? root.optionUnit : ""
        iconSource: root.optionIcon
        unitOnTop: root.unitOnTop
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: ConfigSlider {
        id: sliderWindow
        anchors.fill: parent

        unitOnTop: root.unitOnTop
        optionName: root.optionName
        optionIcon: root.optionIcon
        useSliderColoring: root.useSliderColoring

        options: root.options
        optionIndex: root.optionIndex
        optionUnit: root.optionUnit
        optionEnabled: root.optionEnabled
        isOptionDeactivated: root.isOptionDeactivated || manualChecked
        hasManualOption: root.hasManualOption
    }
}
