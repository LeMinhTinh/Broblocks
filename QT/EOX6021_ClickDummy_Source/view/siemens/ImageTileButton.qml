import QtQuick 2.12

TileButton {
    id: root
    property string title
    property string imageSource
    property string iconSource
    property string iconSourceSecondary
    property real iconCenterOffsetToTop: 0.5 * (height - textAreaHeight)
    property real textAreaHeight: 120
    property real textBaselineOffset: 48
    property bool centerInTextArea: false
    property color iconColor: "#ffffff"
    property color iconColorSecondary: iconColor
    property color textColor: "#ffffff"
    property real textBackgroundOpacity: 0.08
    property bool showText: true
    property real textSize: constants.textSizeF1
    property real textSideMargin: 21
    property color backgroundColor: "transparent"
    property real backgroundOpacity: 1.0
    property int maximumTextLines: 3
    property bool centerTextHorizontally: iconSource

    property bool hasFlyInAnimation: false
    property bool runFlyInAnimation: hasFlyInAnimation
    property real flyInInitialX : 1230
    property int indexOffset: 0
    property real flyinDelay: (hasFlyInAnimation ? (index + indexOffset) : 0) * 1000.0 / 30.0
    property real flyInTime: 666
    property real flyInOvershootX: -(1.5 * root.width + 25 + 6)
    property real flyInBouncebackTime: 733
    property real maximumGapTime: 133
    SequentialAnimation {
        running: runFlyInAnimation

        ParallelAnimation {
            PropertyAction {
                target: staticContentComposit
                property: "x"
                value: flyInInitialX
            }
            PropertyAction {
                target: staticContentComposit
                property: "opacity"
                value: 0
            }
            PauseAnimation {
                duration: flyinDelay
            }
        }
        ParallelAnimation {
            NumberAnimation {
                target: staticContentComposit
                property: "x"
                to: flyInOvershootX
                duration: flyInTime
                easing.bezierCurve: [0.27,0,0,1,1,1]
            }
            NumberAnimation {
                target: staticContentComposit
                property: "opacity"
                to: 1
                duration: flyInTime
            }
        }
        PauseAnimation {
            duration: Math.max(0, maximumGapTime - flyinDelay)
        }
        NumberAnimation {
            target: staticContentComposit
            property: "x"
            to: 0
            duration: flyInBouncebackTime
            easing.bezierCurve: [0.12,0.15,0.35,1,1,1]
        }
    }

    implicitWidth: constants.imageTileWidth
    implicitHeight: constants.imageTileHeight

    ShaderEffectSource {
        id: staticContentComposit
        width: staticContent.width
        height: staticContent.height
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
            opacity: backgroundOpacity
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.top
            anchors.verticalCenterOffset: iconCenterOffsetToTop
            spacing: 20
            Icon {
                source: iconSource
                color: iconColor
                visible: iconSource
                anchors.verticalCenter: parent.verticalCenter
            }
            Icon {
                source: iconSourceSecondary
                color: iconColorSecondary
                visible: iconSourceSecondary
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Item {
            id: textBackground
            y: parent.height - height
            width: parent.width
            height: textAreaHeight
            Component {
                id: smoothedTextBackground
                Item {
                    ShaderEffectSource {
                        id: imageCutout
                        anchors.fill: parent
                        sourceRect: Qt.rect(textBackground.x, textBackground.y, width, height)
                        sourceItem: buttonImage
                        visible: false
                    }

                    GaussianSmoothing {
                        anchors.fill: parent
                        source: imageCutout
                        sigma: 20
                    }
                }
            }
            Loader {
                anchors.fill: parent
                active: imageSource
                sourceComponent: imageSource ? smoothedTextBackground : undefined
            }

            Rectangle {
                anchors.fill: parent
                color: "#ffffff"
                opacity: textBackgroundOpacity
            }
        }

        TextLabel {
           id: imageLabel
           anchors.left: parent.left
           anchors.leftMargin: textSideMargin
           anchors.right: parent.right
           anchors.rightMargin: textSideMargin
           anchors.verticalCenter: centerInTextArea ? textBackground.top : undefined
           anchors.verticalCenterOffset: 0.5 * root.textAreaHeight
           anchors.baseline: centerInTextArea ? undefined : textBackground.top
           anchors.baselineOffset: textBaselineOffset
           fontPixelSize: textSize
           maximumLineCount: maximumTextLines
           color: textColor
           text: title
           doElide: true
           visible: showText
           horizontalAlignment: centerTextHorizontally ? Text.AlignHCenter : Text.AlignLeft
        }
    }
}
