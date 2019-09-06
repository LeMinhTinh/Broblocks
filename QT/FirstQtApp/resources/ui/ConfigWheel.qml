import QtQuick 2.11
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.11

Item {
    id: root

    // Needs to be set
    property int numberOfVisibleSideBars
    property var options: [""]
    property string optionName
    property string optionIcon
    property bool optionEnabled
    property int optionIndex
    property int periodOfWheelLabel

    // initially set but changable
    property real visibleAngle: Math.PI/2
    property int screenOffset: 14
    property int screenLength: width - 2 * screenOffset
    property real percentageOfSeperator: 0.05
    property int barHeight: 11
    property int swipeAreaHeight: 115
    property bool isCircular: true
    property bool isEnabled: optionEnabled
    property real frictionCoefficient: 1.2
    property bool isOptionDeactivated: false

    // constants
    readonly property real overshootFactor: 0.4
    readonly property int maxRotationTime: 4

    // will be calculated:
    property real anglePerIndex: visibleAngle / (2 * numberOfVisibleSideBars + 1)
    property real barAngle: anglePerIndex * (1 - percentageOfSeperator)
    property real maxWheelAngle: overshootFactor * barAngle
    property real minWheelAngle: -(options.length - 1) * anglePerIndex - overshootFactor * barAngle
    property real halfVisibleAngleCosinus: Math.cos(visibleAngle / 2)
    // Calculate the radius of the simulated wheel
    property real radius: screenLength * (1 / halfVisibleAngleCosinus - halfVisibleAngleCosinus) / (2 * Math.tan(visibleAngle / 2) * (1 - halfVisibleAngleCosinus))
    // Calculate the distance between observer and wheel
    property real distance: radius * (1 - halfVisibleAngleCosinus) / halfVisibleAngleCosinus
    property int currentOptionIndex: optionIndex
    property int currentIndex
    property real deltaAlpha
    property real targetAlpha
    property real rotationTime

    property Animation spin:
        NumberAnimation {
        target: root
        property: "deltaAlpha"
        duration: rotationTime * 1000
        easing.type: Easing.OutQuint
        to: targetAlpha
        alwaysRunToEnd: false

        onStopped: {
            moveToCenter.start()
        }
    }

    function getNextCenter() {
       return -currentIndex * anglePerIndex
    }

    property Animation moveToCenter:
        NumberAnimation {
        target: root
        property: "deltaAlpha"
        duration: Math.abs(getNextCenter() - deltaAlpha) * 1000
        easing.type: Easing.OutCubic
        to: getNextCenter()
    }

    onDeltaAlphaChanged: {
        root.currentIndex = -Math.round(deltaAlpha / anglePerIndex)
        root.currentOptionIndex = currentIndex >= 0 ? currentIndex % options.length : (options.length - 1) + (currentIndex + 1) % options.length
    }

    onOptionIndexChanged: {
        if(optionIndex != currentOptionIndex) currentOptionIndex = optionIndex
        if(!swipeArea.inProgress && !spin.running)
            deltaAlpha = -currentOptionIndex * anglePerIndex
    }

    onOptionEnabledChanged: {
        if(optionEnabled != isEnabled) isEnabled = optionEnabled
    }

    function calculateSpin(gestureVelocity) {
        var velocity = gestureVelocity / radius

        if(spin.running)
            spin.stop()

        var friction = -frictionCoefficient * velocity
        targetAlpha = Math.floor((-0.5 * velocity * velocity / friction + deltaAlpha) / anglePerIndex) * anglePerIndex
        rotationTime = Math.abs(velocity / friction)

        if(!isCircular) {
            if(targetAlpha > maxWheelAngle) {
                targetAlpha = maxWheelAngle
            }
            else if(targetAlpha < minWheelAngle) {
                targetAlpha = minWheelAngle
            }
            rotationTime =  Math.abs((targetAlpha - deltaAlpha) / friction)

        }

        if(rotationTime > maxRotationTime) {
            rotationTime = maxRotationTime
        }
        spin.start()
    }

    // Calculates x from alpha, where x is the distance from the center
    function projection(alpha) {
        return (Math.sin(alpha) * distance * radius) / (distance + radius - Math.cos(alpha) * radius)
    }

    function getIndex(index) {
        return index >= 0 ? index % options.length : (options.length - 1) + (index + 1) % options.length
    }

    function isInRange(index) {
        return index >= 0 && index < options.length
    }

    function getBarIndexFromCenter(lfa, rfa) {
        var center = (lfa + rfa) / 2
        return Math.round((center - deltaAlpha) / anglePerIndex)
    }

    // Colorgradient for Repeater
    LinearGradient {
        id: wheelGradient
        anchors.horizontalCenter: parent.horizontalCenter
        width: screenLength
        height: 2 * barHeight
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop { position: 0.0; color: "#002d73ff" }
            GradientStop { position: 0.025; color: "#002d73ff" }
            GradientStop { position: 0.15; color: "#a62d73ff" }
            GradientStop { position: 0.5; color: constants.highlightBlue }
            GradientStop { position: 0.85; color: "#a62d73ff" }
            GradientStop { position: 0.975; color: "#002d73ff" }
            GradientStop { position: 1.0; color: "#002d73ff" }
        }
        cached: true
        visible: false
    }

    LinearGradient {
        id: inactiveGradient
        anchors.horizontalCenter: parent.horizontalCenter
        y: 2 * barHeight
        width: screenLength
        height: 2 * barHeight
        start: Qt.point(0, 0)
        end: Qt.point(width, 0)
        gradient: Gradient {
            GradientStop {position: 0.0; color: constants.fadedInactiveColor }
            GradientStop {position: 0.025; color: constants.fadedInactiveColor }
            GradientStop {position: 0.5; color: constants.inactiveColor }
            GradientStop {position: 0.975; color: constants.fadedInactiveColor }
            GradientStop {position: 1.0; color: constants.fadedInactiveColor }
        }
        cached: true
        visible: false
    }

    // Build the bars to be rendered
    Repeater {
        id: wheelBuilder
        model: 2 * numberOfVisibleSideBars + 1
        anchors.left: parent.left

        ShaderEffectSource {
            id: wheelRectangle
            property real centerAngle: (-numberOfVisibleSideBars + index) * anglePerIndex + deltaAlpha + currentIndex * anglePerIndex
            property real leftFlankAngle: centerAngle - 0.5 * barAngle
            property real rightFlankAngle: centerAngle + 0.5 * barAngle
            property real leftFlank: projection(leftFlankAngle)
            property real rightFlank: projection(rightFlankAngle)
            property int barIndex: getBarIndexFromCenter(leftFlankAngle, rightFlankAngle)
            x: leftFlank + root.width / 2
            y: 114
            height: barHeight
            width:  rightFlank - leftFlank
            sourceRect: Qt.rect(x - wheelGradient.x, 0, width, height)
            sourceItem: !isOptionDeactivated && (isCircular || isInRange(barIndex)) ? wheelGradient : inactiveGradient
            visible:  true
            TextLabel {
                 property real relativePosition: Math.abs(parent.leftFlank + parent.rightFlank) / screenLength
                 fontPixelSize: constants.descriptionTextSize * (1 - 0.5 * relativePosition)
                 opacity: relativePosition > 0.95 ? 0 : Math.pow(1 - relativePosition / 0.95, 0.25)
                 text: options[getIndex(barIndex)]
                 color: isOptionDeactivated ? constants.inactiveColor : themedLightContrastColor
                 anchors.top: parent.bottom
                 anchors.topMargin: 20
                 anchors.horizontalCenter: parent.horizontalCenter
                 visible: isCircular || isInRange(barIndex) ? (barIndex % periodOfWheelLabel == 0) : false
            }
        }
    }

    // Handle Drag and Swipe
    BasicSwipeArea {
        id: swipeArea

        preventStealing: true
        onDragInProgress: {
            deltaAlpha = deltaAlpha + diff / root.radius
            if(!isCircular) {
                if (deltaAlpha > maxWheelAngle)
                    deltaAlpha = maxWheelAngle
                else if(deltaAlpha < minWheelAngle){
                    deltaAlpha = minWheelAngle
                }
            }
        }

        anchors.bottom: optionNameLabel.top
        anchors.bottomMargin: -25
        x: 14
        width: screenLength
        height: barHeight + swipeAreaHeight


        onSwipeEnded: {
            calculateSpin(velocity)
        }

        onSwipeClicked: {
            if (spin.running && Math.abs(delta) < 5)
                spin.stop()
            else if (!spin.running) {
                // TODO Replace with proper determination of the clicked bar (inverse projection)
                var pos = mouseX - screenLength / 2
                for (var i = 0; i < wheelBuilder.count; ++i) {
                    var item = wheelBuilder.itemAt(i)
                    if (pos > item.leftFlank && pos < item.rightFlank) {
                        targetAlpha = deltaAlpha - (item.leftFlankAngle + item.rightFlankAngle) / 2
                        if (!isCircular) {
                            if(targetAlpha > maxWheelAngle) break
                            if(targetAlpha < minWheelAngle) break
                        }
                        rotationTime = 0.3
                        spin.start()
                        break
                    }
                }
            }
        }

        onPressAndHold: {
            if(spin.running) {
                spin.stop()
            }
        }

        onDragEnded: {
             moveToCenter.start()
        }
    }

    RowLayout {
            id: optionNameLabel
            anchors.horizontalCenter: root.horizontalCenter
            anchors.verticalCenter: root.bottom
            anchors.verticalCenterOffset: -52
            spacing: 20

        Icon {
            source: root.optionIcon
            color: themedLightContrastColor
        }

        TextLabel {
            fontPixelSize: constants.descriptionTextSize
            color: themedLightContrastColor
            text: root.optionName
        }
    }
}
