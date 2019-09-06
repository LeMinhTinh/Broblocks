import QtQuick 2.12

MouseArea {
    property bool checked: false
    property string label: ""
    property color labelColor: themedStrongContrastColor
    property color checkboxColor: themedStrongContrastColor
    property color checkColor: constants.defaultBlue
    property real spacing: 20
    property bool positionLabelRight: true

    implicitWidth: checkedCheckBox.implicitWidth + boxLabel.implicitWidth + spacing
    implicitHeight: checkedCheckBox.implicitHeight

    onClicked: checked = !checked

    Icon {
        id: checkedCheckBox
        anchors.left: positionLabelRight ? parent.left : undefined
        anchors.right: positionLabelRight ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: checked
        source: "file:resources/siemens/icons/icn_box_checked.png"
        color: checkboxColor
    }
    Icon {
        anchors.left: positionLabelRight ? parent.left : undefined
        anchors.right: positionLabelRight ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: !checked
        source: "file:resources/siemens/icons/icn_box_unchecked.png"
        color: checkboxColor
    }
    Icon {
        anchors.left: positionLabelRight ? parent.left : undefined
        anchors.right: positionLabelRight ? undefined : parent.right
        anchors.verticalCenter: parent.verticalCenter
        visible: checked
        source: "file:resources/siemens/icons/icn_box_check.png"
        color: checkColor
    }

    TextLabel {
        id: boxLabel
        anchors.left: positionLabelRight ? checkedCheckBox.right : parent.left
        anchors.leftMargin: positionLabelRight ? spacing : 0
        anchors.rightMargin: positionLabelRight ? 0 : spacing
        anchors.right: positionLabelRight ? parent.right : checkedCheckBox.left
        anchors.verticalCenter: parent.verticalCenter
        fontPixelSize: constants.textSizeF1
        color: labelColor
        text: label
    }
}
