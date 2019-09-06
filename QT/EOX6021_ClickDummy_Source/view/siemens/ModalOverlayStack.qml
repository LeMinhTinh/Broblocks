import QtQuick 2.12
import QtQuick.Controls 2.12

StackView {
    id: root

    pushEnter: null
    popEnter:null
    replaceEnter: null

    pushExit: null
    popExit: null
    replaceExit: null

    function open(content, width, height, closeCallback, hasTimer, timeout) {
        return push(overlay, {"content": content,
                 "hasTimer": (hasTimer === undefined) ? false : hasTimer,
                 "closeTimeout": (timeout === undefined) ? 1500 : timeout,
                 "boxWidth": (width === undefined) ? 1088 : width,
                 "boxHeight": (height === undefined) ? 462 : height,
                 "closeCallback": (closeCallback === undefined) ? function() {} : closeCallback})
    }

    function openURL(url, properties, width, height, hasCloseButton, closeCallback, hasTimer, timeout) {
        return push(overlay, {"componentURL": url,
                 "urlProperties": (properties === undefined) ? {} : properties,
                 "hasTimer": (hasTimer === undefined) ? false : hasTimer,
                 "closeTimeout": (timeout === undefined) ? 1500 : timeout,
                 "boxWidth": (width === undefined) ? 1088 : width,
                 "boxHeight": (height === undefined) ? 462 : height,
                 "closeCallback": (closeCallback === undefined) ? function() {} : closeCallback,
                 "hasCloseButton": (hasCloseButton === undefined) ? true : hasCloseButton})
    }

    initialItem: Item {}
    function terminate() {
        pop(null)
    }

    Component {
        id: overlay

        MouseArea {
            id: overlayArea
            property Component content
            property string componentURL
            property var urlProperties
            property bool hasTimer
            property int closeTimeout
            property real boxWidth
            property real boxHeight
            property var closeCallback
            property bool hasCloseButton: true
            opacity: 0
            preventStealing: true
            onClicked: close()
            StackView.visible: true

            function close() {
                closeAnimation.start()
            }

            Timer {
                id: closeTimer
                running: hasTimer && (overlayArea.StackView.status === StackView.Active)
                interval: closeTimeout
                onTriggered: close()
            }

            ParallelAnimation {
                running: true
                NumberAnimation {
                    target: overlayArea
                    property: "opacity"
                    to: 1
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            property bool closeScheduled: false
            SequentialAnimation {
                id: closeAnimation
                NumberAnimation {
                    target: overlayArea
                    property: "opacity"
                    to: 0
                    duration: 250
                    easing.type: Easing.OutCubic
                }
                ScriptAction {
                    script: {
                        closeCallback()
                        if (overlayArea.StackView.visible) root.pop()
                        else closeScheduled = true
                    }
                }
            }
            StackView.onStatusChanged: if ((StackView.status === StackView.Active) && closeScheduled) root.pop(overlayArea)

            Rectangle {
                id: shroud
                anchors.fill: parent
                color: "#000000"
                opacity: 0.5
            }
            MouseArea {
                anchors.centerIn: parent
                width: boxWidth
                height: boxHeight
                ShaderEffectSource {
                    id: backgroundSource
                    anchors.fill: parent
                    sourceRect: Qt.rect(parent.x, parent.y, width, height)
                     // TODO no layer on layer? root.depth > 2 ? modalOverlay.get(modalOverlay.depth - 2) : display
                    sourceItem: display
                    live: true
                    visible: false
                }
                GaussianSmoothing {
                    id: blurredBackground
                    anchors.fill: backgroundSource
                    source: backgroundSource
                    sigma: 40
                    /*Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        opacity: 0.5
                    }*/
                }
                Rectangle {
                    id: popUpColor
                    anchors.fill: parent
                    color: themedStrongContrastColor
                    opacity: 0.08
                }

                Loader {
                    id: contentLoader
                    property alias overlayBase: overlayArea
                    anchors.fill: parent
                    sourceComponent: content
                    Component.onCompleted: if (!content) setSource(componentURL, urlProperties)
                }

                IconButton {
                    width: 68
                    height: 68
                    id: closeIcon
                    anchors.top: parent.top
                    anchors.right: parent.right
                    source: "file:resources/siemens/icons/icn_close.png"
                    color: "#ffffff"
                    onClicked: close()
                    visible: hasCloseButton
                }

                TileShine {}
                TileShadow {}
            }
        }
    }
}
