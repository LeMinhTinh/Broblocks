import QtQuick 2.12

Item {
    id: root

    property real delay
    property real animationTime
    property real value: animationPrimed ? 0.0 : 1.0
    property int easingType: Easing.Bezier
    property bool animationPrimed: true

    function run() {
        if(animationPrimed && isFinite(animationTime) && isFinite(delay)) {
            value = 0.0
            animationPrimed = false
            pause.duration = delay
            activity.duration = animationTime
            animation.running = true
        }
    }
    onAnimationTimeChanged: run()
    onDelayChanged: run()
    onAnimationPrimedChanged: run()

    SequentialAnimation {
        id: animation
        running: false

        PauseAnimation {
            id: pause
        }

        NumberAnimation {
            id: activity
            target: root
            property: "value"
            to: 1.0
            easing.type: root.easingType
            easing.bezierCurve: [0.0047,0.278,0.034,1,1,1]
        }
    }
}
