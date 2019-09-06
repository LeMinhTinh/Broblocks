import QtQuick 2.12

MouseArea {
    id: root
    property Item content: Item {}
    property Item header: Item {}
    property Item footer: Item {}

    width: 1280
    height: 544

    property string backgroundSource
    property Item background: Image {
        source: backgroundSource
    }
    onBackgroundChanged: anchorBackground()
    onBackgroundSourceChanged: anchorBackground()
    function anchorBackground() {
        background.z = -9
        background.parent = root
        background.anchors.centerIn = root
    }
    property Item blurredBackground: GaussianSmoothing {
        source: background
        sigma: 40
        x: background.x
        y: background.y
        width: background.width
        height: background.height
    }

    property real backgroundFadeInTime: 0
    property real backgroundPushFadeInTime: 500
    property real fadeInTime: 500
    property real pushFadeInTime: 500
    property real fadeOutTime: 500
    property real footerFadeInTime: 0
    property real footerPushFadeInTime: 0
    property real initialFooterBottomMargin: 0
    property real contentEntryScale: 1.0
    property real contentExitScale: 1.0
    property real headerFadeTime: 0

    signal popEnterStarted()
    signal popExitStarted()
    signal pushEnterStarted()
    signal pushExitStarted()

    property Animation popExitAnimation: ParallelAnimation {
        ScriptAction {script: popExitStarted()}
        NumberAnimation {
            target: header
            property: "opacity"
            to: 0
            duration: headerFadeTime
            easing.type: Easing.OutCubic
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
    }

    property Animation popEnterAnimation: ParallelAnimation {
        ScriptAction {script: popEnterStarted()}
        NumberAnimation {
            target: header
            property: "opacity"
            from: 0
            to: 1
            duration: headerFadeTime
            easing.type: Easing.OutCubic
        }
        ScriptAction { script: if (footer.actionButton) footer.actionButton.fadeInText.start()}
        NumberAnimation {
            target: content
            property: "opacity"
            from: 0
            to: 1
            duration: fadeInTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: background
            property: "opacity"
            from: 0
            to: 1
            duration: backgroundFadeInTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: footer
            property: "opacity"
            from: 0
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
    }

    property Animation pushExitAnimation: ParallelAnimation {
        ScriptAction {script: pushExitStarted()}
        NumberAnimation {
            target: header
            property: "opacity"
            to: 0
            duration: headerFadeTime
            easing.type: Easing.OutCubic
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

    property Animation pushEnterAnimation: ParallelAnimation {
        ScriptAction {script: pushEnterStarted()}
        NumberAnimation {
            target: header
            property: "opacity"
            from: 0
            to: 1
            duration: headerFadeTime
            easing.type: Easing.OutCubic
        }
        ScriptAction {script: if (footer.actionButton) footer.actionButton.fadeInText.start()}
        NumberAnimation {
            target: content
            property: "opacity"
            from: 0
            to: 1
            duration: pushFadeInTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: background
            property: "opacity"
            from: 0
            to: 1
            duration: backgroundPushFadeInTime
            easing.type: Easing.OutCubic
        }
        NumberAnimation {
            target: footer
            property: "opacity"
            from: 0
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
        NumberAnimation {
            target: footer.anchors
            property: "bottomMargin"
            from: initialFooterBottomMargin
            to: 0
            duration: pushFadeInTime
            easing.type: Easing.OutCubic
        }
    }

    property alias contentContainer: contentContainer
    Item {
        id: contentContainer
        anchors.fill: root
        anchors.topMargin: header.height
        anchors.bottomMargin: footer.height
        clip: true
    }

    onContentChanged: {
        content.z = 0
        content.opacity = 0
        content.parent = contentContainer
        content.anchors.fill = contentContainer
    }

    // Put header and footer on top of content.
    onHeaderChanged: {
        // TODO attaching to display is a quick hack to eliminate header flicker on popExit/Enter
        header.z = 9
        header.parent = display
        header.anchors.top = display.top
        header.anchors.left = display.left
        header.anchors.right = display.right
    }
    onFooterChanged: {
        footer.z = 9
        footer.parent = display
        footer.anchors.bottom = display.bottom
        footer.anchors.left = display.left
        footer.anchors.right = display.right
    }
}
