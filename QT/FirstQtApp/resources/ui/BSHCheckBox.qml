import QtQuick 2.11

MouseArea {
    property bool checked: false
    property string label: ""
    property color labelColor: themedStrongContrastColor
    property color checkboxColor: themedStrongContrastColor
    property color checkColor: constants.defaultBlue
    property real spacing: 20

    implicitWidth: checkedCheckBox.implicitWidth + boxLabel.implicitWidth + spacing
    implicitHeight: checkedCheckBox.implicitHeight

    onClicked: checked = !checked

    Icon {
        id: checkedCheckBox
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: checked
        source: "file:resources/icons/icn_box_checked.png"
        color: checkboxColor
    }
    Icon {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: !checked
        source: "file:resources/icons/icn_box_unchecked.png"
        color: checkboxColor
    }
    Icon {
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: checked
        source: "file:resources/icons/icn_box_check.png"
        color: checkColor
    }

    TextLabel {
        id: boxLabel
        anchors.left: checkedCheckBox.right
        anchors.leftMargin: spacing
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.descriptionTextSize
        color: labelColor
        text: label
    }
}
