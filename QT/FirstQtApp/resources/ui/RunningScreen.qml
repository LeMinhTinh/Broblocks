import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtMultimedia 5.8
import QtGraphicalEffects 1.0
import bsh.eox6021 1.0


//所有任务的启动/计时画面


BaseScreen {
    id: root
    property EOX6021Program program: backend.currentProgram

    property bool preHeatingMessagePrimed: false
    property bool preHeatingMessageQueued: false
    property real preheatingProgress: backend.currentTemperature / program.definition.temperature.value()
    property bool doneMessageQueued: false
    property bool paused: false

//    property int elapsedTime: backend.wallClock - program.startTime
    property int elapsedTime: date.getSeconds()+date.getMinutes()*60+date.getHours()*3600- program.startTime

    property int elapsedHours: getHours(elapsedTime)
    property int elapsedMinutes: getMinutes(elapsedTime)
    property int elapsedSeconds: getSeconds(elapsedTime)
    property int remainingTime: program.remainingTime
    property string remainingHours: getHours(remainingTime)
    property string remainingMinutes:getMinutes(remainingTime)
    property string remainingSeconds: getSeconds(remainingTime)

    moveInStartPosition: 300
    moveOutEndPosition: 300

    function start() {
        program.start()
        runningVideo.seek(0)
    }
    Component.onCompleted: root.start()

    function timeString(time) {
        return (time < 10) ? "0" + time : time.toString()
    }

    function getHours(seconds) {
        return Math.floor(seconds / 3600)
    }

    function getMinutes(seconds) {
        return Math.floor(seconds / 60) % 60
    }

    function getSeconds(seconds) {
        return seconds % 60
    }

    header: Header {title: qsTr("Wash")}

    function showQueuedMessages() {
        if (preHeatingMessageQueued && !modalOverlay.content)
            showPreHeatingMessage()
        else if (doneMessageQueued && !modalOverlay.content)
            showDoneMessage()
    }

    Connections {
        target: program
        onStatusChanged: {
            switch (program.status) {
                case EOX6021Program.DONE:
                    runningVideo.stop()
                    doneMessageQueued = true
                    break;
                case EOX6021Program.PAUSE:
                    if(!paused)
                        runningVideo.play()
                    else
                        runningVideo.pause()
                    doneMessageQueued = false
                    break;
                case EOX6021Program.IDLING:
                    preHeatingMessagePrimed = false
                    break;
                case EOX6021Program.PREHEATING:
                    runningVideo.play();
                    preHeatingMessagePrimed = true
                    break;
                case EOX6021Program.HEATING:
                    runningVideo.play();
                    if (preHeatingMessagePrimed) {
                        preHeatingMessageQueued = true
                        preHeatingMessagePrimed = false
                    }
                    break;
            }
            showQueuedMessages()
        }
    }

    Connections {
        target: modalOverlay
        onContentChanged: showQueuedMessages()
    }

    Connections {
        target: boxInput
        onExtendCalled: {
            modalOverlay.open(boxInput.getRemainingTimeOption())
        }
    }

    function showDoneMessage() {
        modalOverlay.open(boxInput.getFinishOptions(), function() { display.pop(display.get(1)) })
        doneMessageQueued = false
    }

    function showPreHeatingMessage() {
        modalOverlay.open(boxInput.getFinishText(program.definition.temperature.value()), function() { preHeatingMessageQueued = false }, true, 650, 238)
    }

//    backgroundSource: program.definition.runningImage
    Item {
        id:bg
        anchors.fill: parent
//        Image {
//            id: backgroundImage
//            anchors.fill: parent
//            source: program.definition.runningImage
//            visible: program.definition.runningImage
//        }
        Video {
            id: runningVideo
            z:1
            visible: program.definition.runningVideo
            anchors.fill: parent
            source: program.definition.runningVideo
            autoLoad: true
            loops: MediaPlayer.Infinite
            fillMode: VideoOutput.PreserveAspectCrop
            opacity: 0
            onPlaying: opacity = 1
            onStopped: opacity = 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 500
                }
            }

        }
    }
    background: ShaderEffectSource {
        anchors.fill: parent
        sourceItem: bg
        hideSource: true
    }

    content: Item {
        id: contentItem

        // Program title line
        TextLabel {
            id: programTitle
            anchors.top: parent.top
            anchors.topMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.right: parent.right
            anchors.rightMargin: 32
            fontPixelSize: constants.mainTitleTextSize
            color: themedLightContrastColor
            text: program.definition.name
            doElide: true
        }

//        状态栏
        Row {
            id: configLine
            x: 32
            height: 38
            anchors.top: programTitle.baseline
            anchors.topMargin: 40
            spacing: 0
            ConfigInfoButton {
                id: temperature
                iconSource: "file:resources/icons/temperature.png"
                value: preheatingProgress < 1 || preHeatingMessageQueued || preHeatingMessagePrimed ?  Math.floor(backend.currentTemperature) + " / " + program.definition.temperature.value() : Math.floor(backend.currentTemperature)
                valueColor: 'white'
                unit: "°C"
                fontPixelSize: 46
                unitOnTop: true
                isEnabled: program.definition.temperature.isEnabled
//                onClicked: {
//                    modalOverlay.open(boxInput.getTemperatureOptions())
//                }
                isDeactivated: false
                firstLabel: true

                hasProgressBar: preheatingProgress < 1 || preHeatingMessageQueued || preHeatingMessagePrimed
                progress: preheatingProgress
            }
            ConfigInfoButton {
                id: spinspeed
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "file:resources/icons/heat.png"
                value: preheatingProgress < 1 || preHeatingMessageQueued || preHeatingMessagePrimed ?  Math.floor(backend.currentSpinSpeed) + " / " + program.definition.spinspeed.value() : Math.floor(backend.currentSpinSpeed)
                valueColor: 'white'
                unit: " "
                fontPixelSize: 46
                unitOnTop: true
                isEnabled: program.definition.spinspeed.isEnabled
//                onClicked: {
//                    modalOverlay.open(boxInput.getTemperatureOptions())
//                }
                isDeactivated: false
                firstLabel: true

                hasProgressBar: preheatingProgress < 1 || preHeatingMessageQueued || preHeatingMessagePrimed
                progress: preheatingProgress
            }

/*            ConfigInfoButton {
                id: quickHeat
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "file:resources/icons/heating.png"
                value: program.definition.quickHeat.isEnabled ? "on" : "off"
                valueColor: 'white'
                fontPixelSize: 46
                isEnabled: program.definition.quickHeat.isEnabled
                isDeactivated: program.definition.quickHeat.isDeactivated
                state: preheatingProgress < 1 || preHeatingMessageQueued || preHeatingMessagePrimed ? "" : "disabled"
//                onClicked: {
//                    program.definition.quickHeat.isEnabled = !program.definition.quickHeat.isEnabled
//                }
                onIsDeactivatedChanged: {
                    if (isDeactivated && isEnabled && display.currentItem === root) {
                        footer.infoBubble.show({"value": "heating stopped", "iconSource": "file:resources/icons/heating.png"})
                    }
                }
            }
*/
            ConfigInfoButton {
                visible: false
                id: steam
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "file:resources/icons/steam_encore.png"
                value: program.definition.steam.isInAlternativeMode ? "manually" : (program.definition.steam.isEnabled ? program.definition.steam.options[program.definition.steam.currentIndex] : "off")
                valueColor: 'white'
                fontPixelSize: 46
                isEnabled: program.definition.steam.isEnabled
                isDeactivated: program.definition.steam.isDeactivated
//                onClicked: modalOverlay.open(boxInput.getSteamOption())
                onIsDeactivatedChanged: {
                    if (isDeactivated && (isEnabled || program.definition.steam.isInAlternativeMode) && display.currentItem === root) {
                        footer.infoBubble.show({"value": "Steam addition deactivated", "iconSource": "file:resources/icons/steam_encore.png"})
                    }
                }
            }
            ConfigInfoButton {
                visible: false
                id: microwave
                anchors.verticalCenter: parent.verticalCenter
                iconSource: "file:resources/icons/microwave.png"
                value: program.definition.microwave.isEnabled ? program.definition.microwave.options[program.definition.microwave.currentIndex] : "out"
                valueColor: 'white'
                fontPixelSize: 46
                unitOnTop: true
                unit: program.definition.microwave.isEnabled ? "W" : ""
                isEnabled: program.definition.microwave.isEnabled
                isDeactivated: program.definition.microwave.isDeactivated
//                onClicked: {
//                    modalOverlay.open(boxInput.getMicrowaveOption())
//                }
                onIsDeactivatedChanged: {
                    if (isDeactivated && isEnabled && display.currentItem === root) {
                        footer.infoBubble.show({"value": "Microwave disabled", "iconSource": "file:resources/icons/microwave.png"})
                    }
                }
                lastLabel: true
            }
        }

        // Remaining time label
        Item {
            x: 40
            height: 142
            anchors.bottom: parent.bottom
            TextLabel {
                id: remainingTimeLabel
                anchors.top: parent.top
                anchors.left: parent.left
                text: "Remaining"
                color:themedLightContrastColor
                fontPixelSize: constants.descriptionTextSize
            }
            ConfigString {
                id: remainingTimeValue
                anchors.verticalCenter: remainingTimeLabel.baseline
                anchors.verticalCenterOffset: 50
                anchors.left: parent.left
                iconSource: "file:resources/icons/remaining.png"
                iconColor: program.remainingTime >= 0 ? constants.defaultBlue : themedStrongContrastColor
                value: program.remainingTime >= 0 ? timeString(remainingHours > 0 ? remainingHours : remainingMinutes) : "--"
                unit: remainingHours > 0 ? "h" : "m"
                valueSecondary: program.remainingTime >= 0 ? timeString(remainingHours > 0 ? remainingMinutes : remainingSeconds) : "--"
                unitSecondary: remainingHours > 0 ? "m" : "s"
                seperatorString: " "
                unitOnTop: false
                valueColor: "white"
            }

            MouseArea {
                anchors.fill: remainingTimeValue
//                onClicked: {
//                    modalOverlay.open(boxInput.getRemainingTimeOption())
//                }
            }
        }

        // RunningTime
        Item {
            x: 978
            height: 142
            anchors.bottom: parent.bottom
            visible: program.remainingTime < 0
            TextLabel {
                id: runningTimeLabel
                anchors.top: parent.top
                anchors.left: parent.left
                text: "Elapse"
                color:themedLightContrastColor
                fontPixelSize: constants.descriptionTextSize
            }
            ConfigString {
                anchors.verticalCenter: runningTimeLabel.baseline
                anchors.verticalCenterOffset: 50
                anchors.left: parent.left
                iconSource: "file:resources/icons/elapse.png"
                iconColor: constants.defaultBlue
                value: timeString(elapsedHours > 0 ? elapsedHours : elapsedMinutes)
                unit: elapsedHours > 0 ? "h" : "m"
                valueSecondary: timeString(elapsedHours > 0 ? elapsedMinutes : elapsedSeconds)
                unitSecondary: elapsedHours > 0 ? "m" : "s"
                seperatorString: " "
                unitOnTop: false
                valueColor: "white"
            }
        }

        // Ends at 结束时间
        Item {
            x: 978
            height: 142
            anchors.bottom: parent.bottom
            visible: program.remainingTime >= 0
            TextLabel {
                id: endLabel
                anchors.top: parent.top
                anchors.left: parent.left
                text: "End At"
                color:themedLightContrastColor
                fontPixelSize: constants.descriptionTextSize
            }
            ConfigString {
                id: endString
                anchors.verticalCenter: endLabel.baseline
                anchors.verticalCenterOffset: 50
                anchors.left: parent.left
                iconSource: "file:resources/icons/end_at.png"
                iconColor: constants.defaultBlue
                value: timeString(getHours(remainingTime + date.getSeconds()+date.getMinutes()*60+date.getHours()*3600) % 24)
                valueSecondary: timeString(getMinutes(remainingTime + date.getSeconds()+date.getMinutes()*60+date.getHours()*3600))
                seperatorString: ":"
                unitOnTop: false
                valueColor: "white"
            }
        }

        ProgressBar {
            id: progressBar
            y: parent.height - 0.5 * mm - height
            width: parent.width
            height: 1.4 * mm
            property real progress: elapsedTime  / (elapsedTime + remainingTime)
            value: progress > 1 ? 0 : progress
            Behavior on value {
                NumberAnimation {
                    duration: 1000
                }
            }

            background: Rectangle {
                color: "#999999"
                opacity: 0.6
            }
            visible: remainingTime >= 0
            contentItem: Item {
                implicitHeight: 4
                Rectangle {
                    width: progressBar.visualPosition * parent.width
                    height: parent.height
                    LinearGradient {
                        anchors.fill: parent
                        start: Qt.point(0, 0)
                        end: Qt.point(parent.width, 0)
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#006fd3" }
                            GradientStop { position: 1.0 / progressBar.visualPosition; color: "#28bbff" }
                        }
                    }
                }
            }
        }
    } // end of content Item

    footer: Footer {
        id: footer
        backgroundSource: blurredBackground
        actionButtonText: paused? qsTr("Run"):qsTr("Pause")
        cancelButtonText: qsTr("Abort")
        onAction: function () {
            if(!paused)
            {
                paused = true
                //actionButtonText: qsTr("Run")
            }
            else
            {
                paused = false
                //actionButtonText: qsTr("Pause")
            }
               program.pause();
            //display.pop()
        }
        onCancel: function () {
            program.terminate();
            display.pop()
        }

    }

    RunningScreenInfoOverlayComponents {
        id: boxInput
        onConfirm: {
            modalOverlay.close()
        }
    }
}
