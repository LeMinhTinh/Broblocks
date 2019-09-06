import QtQuick 2.12
Canvas {
    id: root
    property int seconds

    property real radius: 145
    property real bigTickThickness: 4
    property real bigTickLength: 25
    property real smallTickThickness: 3
    property real smallTickLength: 3
    property color tickColor: Qt.rgba(1, 1, 1, 1)
    property real ringThickness: 14
    property color ringColor: Qt.rgba(1, 1, 1, 1)
    property real hourArmLength: 0.65 * (radius - ringThickness)
    property real hourArmThickness: approximateInNativeResolution(8)
    property real minuteArmLength: 0.925 * (radius - ringThickness)
    property real minuteArmThickness: hourArmThickness
    property color armColor: Qt.rgba(1, 1, 1, 1)
    property real armOverHang: 25
    property real centerArmRingThickness: approximateInNativeResolution(8)
    property real centerThickness: approximateInNativeResolution(3)
    property color centerColor: Qt.rgba(0, 0, 0, 1)

    property real centerX: 0.5 * width
    property real centerY: 0.5 * height
    width: 2 * radius + ringThickness
    height: width
    renderTarget: Canvas.FramebufferObject
    renderStrategy: Canvas.Cooperative

    onSecondsChanged: requestPaint()

    onPaint: {
        var context = getContext("2d")
        context.reset()

        // Ticks
        context.strokeStyle = tickColor;
        for (var tick = 0; tick < 60; ++tick) {
            var tickAngle = tick * Math.PI / 30.0
            var tickLength = 0.5 * ringThickness + ((tick % 5) ? smallTickLength : bigTickLength)
            var tickThickness =  (tick % 5) ? smallTickThickness : bigTickThickness
            context.beginPath()
            context.lineWidth = tickThickness
            context.moveTo(centerX + radius * Math.cos(tickAngle), centerY - radius * Math.sin(tickAngle))
            context.lineTo(centerX + (radius - tickLength) * Math.cos(tickAngle), centerY - (radius - tickLength) * Math.sin(tickAngle))
            context.stroke()
        }

        /*/ Ring
        context.beginPath()
        context.lineWidth = ringThickness
        var shade = context.createRadialGradient(centerX, centerY, radius - 0.5 * ringThickness, centerX, centerY, radius + 0.5 * ringThickness)
        shade.addColorStop(0.0, Qt.rgba(0, 0, 0, 1))
        shade.addColorStop(0.5, ringColor)
        shade.addColorStop(1.0, Qt.rgba(0, 0, 0, 1))
        context.strokeStyle = shade;
        context.arc(centerX, centerY, radius, 0 , 2 * Math.PI, false)
        context.stroke()//*/

        // Arms
        var minute = getMinutes(seconds)
        var minuteAngle = (0.5 - minute / 30.0) * Math.PI
        var hour = getHours(seconds) % 12 + minute / 60.0
        var hourAngle = (0.5 - hour / 6.0) * Math.PI
        context.strokeStyle = armColor
        context.beginPath()
        context.lineWidth = hourArmThickness
        context.moveTo(centerX - armOverHang * Math.cos(hourAngle), centerY + armOverHang * Math.sin(hourAngle))
        context.lineTo(centerX + hourArmLength * Math.cos(hourAngle), centerY - hourArmLength * Math.sin(hourAngle))
        context.stroke()
        context.beginPath()
        context.lineWidth = minuteArmThickness
        context.moveTo(centerX - armOverHang * Math.cos(minuteAngle), centerY + armOverHang * Math.sin(minuteAngle))
        context.lineTo(centerX + minuteArmLength * Math.cos(minuteAngle), centerY - minuteArmLength * Math.sin(minuteAngle))
        context.stroke()
        context.beginPath()
        context.fillStyle = armColor
        context.arc(centerX, centerY, centerArmRingThickness, 0 , 2 * Math.PI, false)
        context.fill()
        context.beginPath()
        context.fillStyle = centerColor
        context.arc(centerX, centerY, centerThickness, 0 , 2 * Math.PI, false)
        context.fill()
    }
}
