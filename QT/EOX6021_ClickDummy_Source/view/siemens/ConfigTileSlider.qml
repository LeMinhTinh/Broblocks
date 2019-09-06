import QtQuick 2.12
import QtQuick.Layouts 1.12

ConfigTile {
    id: root
    property var options
    property int optionIndex
    property string optionUnit
    property bool optionEnabled
    property bool unitOnTop: false
    property bool hasManualOption: false
    property bool showControlDescription: true
    property int currentIndex: optionIndex
    property bool currentEnabled: optionEnabled
    property bool manualChecked
    property bool hasOffPosition: true

    overview: ConfigOverview {
        anchors.fill: parent

        optionName: root.optionName
        value: manualChecked ? "manuell" : (root.optionEnabled ? options[optionIndex] : "aus")
        unit: root.optionEnabled ? root.optionUnit : ""
        iconSource: root.optionIcon
        unitOnTop: root.unitOnTop
        isDeactivated: root.isOptionDeactivated
        isEnabled: root.optionEnabled
    }

    optionWindow: Loader {
        active: visible
        anchors.fill: parent
        sourceComponent: ConfigSlider {
            id: sliderWindow
            anchors.fill: parent

            unitOnTop: root.unitOnTop
            optionName: root.optionName
            optionIcon: root.optionIcon

            options: root.options
            optionIndex: root.optionIndex
            optionUnit: root.optionUnit
            optionEnabled: root.optionEnabled
            hasOffPosition: root.hasOffPosition
            isOptionDeactivated: root.isOptionDeactivated || manualChecked
            hasManualOption: root.hasManualOption
            showOptionDescription: root.showControlDescription

            Binding { target: root; property: "currentIndex"; value: currentIndex }
            Binding { target: root; property: "currentEnabled"; value: isEnabled }
            Binding { target: root; property: "manualChecked"; value: manualChecked }
        }
    }
}
