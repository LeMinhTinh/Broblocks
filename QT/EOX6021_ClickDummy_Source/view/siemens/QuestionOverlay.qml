import QtQuick 2.12
import bsh.backend 1.0

Item {
    id: root
    property string question
    property string cancelAnswer: "Abbrechen"
    property string actionAnswer: "Übernehmen"
    property var cancelCallback: function() {}
    property var confirmCallback: function() {}

    TextLabel {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -0.5 * buttonRow.height
        fontPixelSize: constants.textSizeF1
        horizontalAlignment: Text.AlignHCenter
        color: themedLightContrastColor
        text: root.question
        maximumLineCount: 3
    }

    Row {
        id: buttonRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        spacing: 24
        FooterButton {
            color: "#26ffffff"
            text: root.cancelAnswer
            onClicked: {
                root.cancelCallback()
                overlayBase.close()
            }
        }

        FooterButton {
            color: constants.defaultBlue
            text: root.actionAnswer
            onClicked: {
                root.confirmCallback()
                overlayBase.close()
            }
        }
    }
}
