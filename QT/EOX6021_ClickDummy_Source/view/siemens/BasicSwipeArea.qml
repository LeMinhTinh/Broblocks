import QtQuick 2.12

MouseArea {
    id: root

    readonly property real minDistanceForGesture: 5

    property real oldX: mouseX
    property real originX: mouseX
    property real directionalOriginX: mouseX
    property real diff

    property var lastTime
    property var distance
    property var meanVelocity

    property var gestureStartTime
    property bool inProgress: false

    signal swipeEnded(var velocity)
    signal dragInProgress(var diff)
    signal swipeClicked(var delta)
    signal dragEnded()

    pressAndHoldInterval: 200

    onPressed: {
        inProgress = true
        oldX = mouseX
        gestureStartTime = Date.now()
        lastTime = Date.now()
        distance = 0
        meanVelocity = 0
    }

    onMouseXChanged: {
        // outside of area -> nothing happens
        if (mouseX < parent.x || mouseX > parent.width || inProgress == false)
            return

        // first call: set initials
        if (originX == 0) {
            originX = mouseX
            oldX = mouseX
            return
        }

        diff = mouseX - oldX
        distance = distance + diff

        root.dragInProgress(diff)

        if (Date.now() - lastTime >= 1) {
            meanVelocity = 0.5 * meanVelocity + 0.5 * distance / (Date.now() - lastTime)
            lastTime = Date.now()
            distance = 0
        }

        oldX = mouseX
    }

    onReleased: {
        var now = Date.now()

        if (Math.abs(mouseX - originX) > minDistanceForGesture ) {
            if (Math.abs(meanVelocity) > 2) {
                root.swipeEnded(meanVelocity * 1000)
            } else {
                root.dragEnded()
            }
        } else {
            root.swipeClicked(mouseX - originX)
        }

        originX = 0
        inProgress = false
    }
}
