import QtQuick 2.11
import QtGraphicalEffects 1.0

//所有界面的基类 定义了stackview的动画
MouseArea {
    id: root
    property Item content: Item {}
    property Item header: Item {}
    property Item footer: Item {}

    property string backgroundSource
    property real backgroundScale: 1.0

    Image {
        id:img
        width: backgroundScale * root.width
        height: backgroundScale * root.height
        source: backgroundSource
        visible: false
    }
    property Item background:        FastBlur{
        z:0
        //        anchors.fill: img
        width: backgroundScale * root.width
        height: backgroundScale * root.height
        source: img
        radius: 32
        visible: backgroundSource?true:false
    }

    //    property Item blurredBackground: Item {
    //        width: root.width
    //        height: root.height
    //        GaussianSmoothing {
    //            source: background
    //            radius: 40
    //            x: background.x
    //            y: background.y
    //            width: background.width
    //            height: background.height
    //        }
    //    }

    property Item blurredBackground: Rectangle{
        id:blur
        color: Qt.rgba(1,1,1,0.1)
        width: root.width
        height: root.height
    }

    property Item flickableItem: Item { property int contentX }


    property real backgroundFadeInTime: 0
    property real footerFadeInTime: 0
    property real backgroundPushFadeInTime: 0
    property real footerPushFadeInTime: 0
    property real fadeInTime: 400
    property real pushFadeInTime: 400
    property real contentFadeInDelay: 0
    property real fadeOutTime: 300
    property real initialBackgroundScale: 1.0
    property real targetBackgroundScale: 1.0
    property real flyInInitialContentX: 0
    property real flyInOvershoot: 0
    property real flyInOvershootTime: 0
    property real flyInBouncebackTime: 0
    property real initialFooterBottomMargin: 0
    property real contentEntryScale: 1.0
    property real contentExitScale: 1.0
    property real moveInStartPosition: 0
    property real moveOutEndPosition: 0

    property Animation popExitAnimation: ParallelAnimation {
        PropertyAction {
            target: header
            property: "visible"
            value: false
        }
        ScriptAction { script: if (footer.actionButton) footer.actionButton.fadeOutText.start()}
        NumberAnimation {
            targets: [background, content, footer]
            property: "opacity"
            to: 0
            duration: fadeOutTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            targets: content
            property: "scale"
            from: 1.0
            to: contentEntryScale
            duration: fadeOutTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: content
            properties: "anchors.leftMargin"
            to: moveOutEndPosition
            duration: fadeOutTime
            easing.type: Easing.OutCubic
        }
    }

    property Animation popEnterAnimation: SequentialAnimation {
        ParallelAnimation {
            PropertyAction {
                target: header
                property: "visible"
                value: true
            }
            PropertyAction {
                target: flickableItem
                property: "contentX"
                value: 0
            }
            PropertyAction {
                targets: [background, content, footer]
                property: "opacity"
                value: 0
            }
        }
        ParallelAnimation {
            ScriptAction { script: if (footer.actionButton) footer.actionButton.fadeInText.start()}
            NumberAnimation {
                target: content
                property: "opacity"
                to: 1
                duration: fadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: background
                property: "opacity"
                to: 1
                duration: backgroundFadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: footer
                property: "opacity"
                to: 1
                duration: footerFadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: content
                property: "scale"
                from: contentExitScale
                to: 1.0
                duration: fadeInTime
                easing.type: Easing.OutCubic
            }
            //            NumberAnimation {
            //                targets: root
            //                property: "backgroundScale"
            //                to: targetBackgroundScale
            //                duration: fadeInTime
            //                easing.type: Easing.OutCubic
            //            }
        }
    }

    property Animation pushExitAnimation: ParallelAnimation {
        PropertyAction {
            target: header
            property: "visible"
            value: false
        }
        ScriptAction { script: if (footer.actionButton) footer.actionButton.fadeOutText.start()}
        NumberAnimation {
            targets: [background, content, footer]
            property: "opacity"
            to: 0
            duration: fadeOutTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: content
            property: "scale"
            from: 1.0
            to: contentExitScale
            duration: fadeOutTime
            easing.type: Easing.OutCubic
        }
    }

    property Animation pushEnterAnimation: SequentialAnimation {
        ParallelAnimation {
            PropertyAction {
                target: header
                property: "visible"
                value: true
            }
            PropertyAction {
                target: footer.anchors
                property: "bottomMargin"
                value: initialFooterBottomMargin
            }
            PropertyAction {
                target: content
                property: "anchors.leftMargin"
                value: moveInStartPosition
            }
            PropertyAction {
                targets: [background, content, footer]
                property: "opacity"
                value: 0
            }
            PropertyAction {
                targets: flickableItem
                property: "contentX"
                value: flyInInitialContentX
            }
            //            PropertyAction {
            //                targets: root
            //                property: "backgroundScale"
            //                value: initialBackgroundScale
            //            }
        }
        ParallelAnimation {
            ScriptAction {script: if (footer.actionButton) footer.actionButton.fadeInText.start()}
            SequentialAnimation {
                PauseAnimation {
                    duration: contentFadeInDelay
                }
                NumberAnimation {
                    target: content
                    property: "opacity"
                    to: 1
                    duration: pushFadeInTime - contentFadeInDelay
                    easing.type: Easing.OutCubic
                }
            }
            NumberAnimation {
                target: background
                property: "opacity"
                to: 1
                duration: backgroundPushFadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: footer
                property: "opacity"
                to: 1
                duration: footerPushFadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                targets: content
                property: "scale"
                from: contentEntryScale
                to: 1
                duration: pushFadeInTime
                easing.type: Easing.OutCubic
            }
            //            NumberAnimation {
            //                targets: root
            //                property: "backgroundScale"
            //                to: targetBackgroundScale
            //                duration: pushFadeInTime
            //                easing.type: Easing.OutCubic
            //            }
            NumberAnimation {
                target: footer.anchors
                property: "bottomMargin"
                to: 0
                duration: pushFadeInTime
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: content
                properties: "anchors.leftMargin"
                to: 0
                duration: pushFadeInTime
                easing.type: Easing.OutCubic
            }

            SequentialAnimation {
                NumberAnimation {
                    target: flickableItem
                    property: "contentX"
                    to: flyInOvershoot
                    duration: flyInOvershootTime
                    easing.bezierCurve: [0.5,0,0.2,1,1,1]
                }
                NumberAnimation {
                    target: flickableItem
                    property: "contentX"
                    to: 0
                    duration: flyInBouncebackTime
                    easing.bezierCurve: [0.5,0,0.2,1,1,1]
                }
            }
        }
    }

    width: 1280
    height: 544
    clip: true

    function addBackground() {
        background.z = -9
        background.opacity = 0
        background.parent = root
        background.anchors.centerIn = root
    }

    Component.onCompleted: addBackground()

    onBackgroundChanged: {
        if (background.parent !== root) {
            addBackground()
        }
    }

    onContentChanged: {
        if (content.parent !== root) {
            content.z = 0
            content.opacity = 0
            content.parent = root
            content.anchors.top = root.top
            content.anchors.topMargin = (header.parent === display) ? header.height : 0
            content.anchors.bottom = root.bottom
            content.anchors.bottomMargin = (footer.parent === display) ? footer.height : 0
            content.anchors.left = root.left
            content.anchors.right = root.right
        }
    }

    // Put header and footer on top of content.
    onHeaderChanged: {
        // TODO attaching to display is a quick hack to eliminate header flicker on popExit/Enter
        if (header.parent !== display) {
            header.z = 9
            header.parent = display
            header.anchors.top = display.top
            header.anchors.left = display.left
            header.anchors.right = display.right
            if (content.parent === root) content.anchors.topMargin = header.height
        }
    }
    onFooterChanged: {
        if (footer.parent !== display) {
            footer.z = 9
            footer.opacity = 0
            footer.parent = display
            footer.anchors.bottom = display.bottom
            footer.anchors.left = display.left
            footer.anchors.right = display.right
            if (content.parent === root) content.anchors.bottomMargin = footer.height
        }
    }
}
