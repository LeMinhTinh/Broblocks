import QtQuick 2.11

TileButton {
    id: root
    property string title
    property string imageSource
    property string iconSource
    property real iconOffset: 0
    property real textAreaHeight: 120
    property color iconColor: "#ffffff"
    property color textColor: "white"
    property real colorizationIntensity: 0
    property bool showText: true
    property real textSize: constants.imageTileTextSize
    property alias buttonImage: buttonImage
    property real textSideMargin: 18//58
    property color backgroundColor: "transparent"

    implicitHeight: parent.height
    implicitWidth: height * buttonImage.implicitWidth / buttonImage.implicitHeight

    ShaderEffectSource {
        id: staticContentComposit
        anchors.fill: parent
        sourceRect: Qt.rect(0, 0, staticContent.width, staticContent.height)
        sourceItem: staticContent
        hideSource: true
    }

    Item {
        id: staticContent
        anchors.fill: parent

        Image {
            id: buttonImage
            source: imageSource
            anchors.fill: parent
            visible: imageSource
        }

        Rectangle {
            anchors.fill: parent
            color: backgroundColor
            visible: backgroundColor != "transparent"
        }

        Icon {
            id: buttonIcon
            source: iconSource
            color: iconColor
            visible: iconSource
            anchors.horizontalCenter: parent.horizontalCenter
            y: 0.5 * imageLabel.y - 0.5 * height + iconOffset
        }

        Item {
            id: textBackground
            y: parent.height - height
            width: parent.width
            height: textAreaHeight
            ShaderEffectSource {
                id: imageCutout
                anchors.fill: parent
                sourceRect: Qt.rect(parent.x, parent.y, width, height)
                sourceItem: buttonImage
                visible: false
            }

            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
                visible: colorizationIntensity > 0
            }

            GaussianSmoothing {
                anchors.fill: parent
                source: imageCutout
                radius: 40
                visible: buttonImage
                opacity: 1.0 - colorizationIntensity
            }
        }

        TextLabel {
           id: imageLabel
           anchors.left: parent.left
           anchors.leftMargin: textSideMargin
           anchors.right: parent.right
           anchors.rightMargin: anchors.leftMargin
           anchors.baseline: textBackground.top
           anchors.baselineOffset: 51
           fontPixelSize: textSize
           lineSpacing: 0.5 * textSize
           maximumLineCount: 2
           color: textColor
           text: title
           doElide: true
           visible: showText
           horizontalAlignment: Text.AlignHCenter//sunjie iconSource ? Text.AlignHCenter : Text.AlignLeft
        }
    }
}
