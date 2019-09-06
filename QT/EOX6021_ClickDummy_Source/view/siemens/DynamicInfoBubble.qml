// Shows a white info bubble with its tip at <tipX/tipY>.

import QtQuick 2.12
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.12

Item {
    id: root
    property real tipX
    property real tipY
    property bool pointUpwards: false
    property real horizontalMinimumMarginInParent: 20
    property real bubbleMargin: 12

    anchors.fill: parent

    function show(configuration) {
        showComponent("InfoMessage.qml", configuration)
    }

    function showComponent(component, configuration) {
        var comp = Qt.createComponent(component)
        comp.createObject(bubbleContent, configuration)
    }

    Item {
        id: bubble
        x: {
            var posX = tipX - 0.5 * width
            if (posX < horizontalMinimumMarginInParent) posX = horizontalMinimumMarginInParent;
            else if (posX + width + horizontalMinimumMarginInParent > parent.width) posX = parent.width - width - horizontalMinimumMarginInParent
            return posX
        }
        y: pointUpwards ? tipY : (tipY - height)
        width: background.width
        height: background.height + bubblePointer.height

        Image {
            id: bubblePointer
            source: "file:resources/siemens/icons/BubblePointer.png"
            x: tipX - 0.5 * width - parent.x
            y: pointUpwards ? 0 : (parent.height - height)
            rotation: pointUpwards ? 0 : 180
        }

        Rectangle {
            id: background
            color: "#ffffff"
            radius: 2
            opacity: 0.95

            anchors.top:  pointUpwards ? bubblePointer.bottom : undefined
            anchors.bottom: pointUpwards ? undefined : bubblePointer.top
            width: bubbleContent.width + 2 * bubbleMargin
            height: bubbleContent.height + 2 * bubbleMargin
        }

        Column {
            id: bubbleContent
            anchors.top: background.top
            anchors.topMargin: bubbleMargin
            anchors.left: background.left
            anchors.leftMargin: bubbleMargin
            width: childrenRect.width
            height: childrenRect.height
            spacing: bubbleMargin
        }
    }

    ShaderEffectSource {
        anchors.fill: bubble
        z: 99
        sourceItem: bubble
        hideSource: true
        visible: bubbleContent.children.length > 0
    }
}
