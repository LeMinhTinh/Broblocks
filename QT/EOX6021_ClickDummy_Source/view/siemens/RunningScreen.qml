import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtMultimedia 5.12
import QtGraphicalEffects 1.12
import bsh.backend 1.0

BaseScreen {
    id: root
    property EOX6021Program program: backend.currentProgram

    property bool preHeatingMessageQueued: false
    property real preHeatingProgress: program.definition.temperature ? ((Math.floor(backend.currentTemperature) - 21)  / (program.definition.temperature.value() - 21)) : 0
    property bool doneMessageQueued: false
    property bool flipMessageQueued: false

    property int elapsedTime: (program.status === EOX6021Program.WAITING) ? 0 : (backend.wallClock - program.startTime)
    property int remainingTime: program.remainingTime
    property int waitingTime: program.waitingTime
    RunningScreenInfoOverlayComponents {
        id: boxInput
    }

    property real pushEnterTime: 750
    onPushEnterStarted: bgVideo.load()
    Component.onCompleted:  program.start()
    // TODO poor synchonization workaround
    property bool runFlyInAnimation: false
    Timer {
        running: true
        onTriggered: runFlyInAnimation = true
        interval: 1
    }

    header: Header {}

    Connections {
        target: backend
        onShowPreheatingDoneMessage: {
            preHeatingMessageQueued = true
            showQueuedMessages()
        }
        onShowMealFlipMessage: {
            flipMessageQueued = true
            showQueuedMessages()
        }
    }

    function showQueuedMessages() {
        if (modalOverlay.depth === 1) {
            if (flipMessageQueued) {
                sound_cook_advice.play()
                onShowMealFlipMessage: modalOverlay.openURL("MessagePanel.qml", {"message": "Bitte Wenden!"}, 618, 216, true, function() {flipMessageQueued = false}, true, 1500)
            } else if (preHeatingMessageQueued) {
                sound_cook_advice.play()
                preHeatingMessageQueued = false
                modalOverlay.openURL("MessagePanel.qml", {"message": "Zieltemperatur erreicht!"}, 618, 216, true, function() {}, true, 1500)
            } else if (doneMessageQueued) {
                sound_cook_end.play()
                doneMessageQueued = false
                if (program.definition.isCleaningProgram) display.pop(display.get(1))
                else modalOverlay.open(boxInput.finishOptions, 1232, 496, function() { if (!program.isProgramRunning()) display.pop(display.get(1)) })
            }
        }
    }

    Connections {
        target: program
        onStatusChanged: {
            switch (program.status) {
                case EOX6021Program.DONE:
                    bgVideo.stop()
                    doneMessageQueued = true
                    break;
                case EOX6021Program.PREHEATING:
                    bgVideo.play();
                    break;
                case EOX6021Program.HEATING:
                    bgVideo.play();
                    break;
                case EOX6021Program.TERMINATED:
                    bgVideo.stop()
                    preHeatingMessageQueued = false
                    flipMessageQueued = false
                    doneMessageQueued = false
                    break;
            }
            showQueuedMessages()
        }
    }

    Connections {
        target: modalOverlay
        onDepthChanged: showQueuedMessages()
    }

    backgroundSource: program.definition.runningImage
    Item {
        id:bgVideo
        anchors.fill: parent

        /*/ Expect videos in folder <imagePath> named like 0..1.<imageType> - 0..<numberOfFrames>.<imageType>
        // where the number of digits in the name is fixed zeropaded to <imageType>
        Item {
            id: runningVideo
            anchors.fill: parent
            property int currentImage: 1
            property string imagePath: "file:resources/siemens/videos/Heatwaves_red/"
            property string imageType: ".png"
            property int maxDigits: 5
            property int numberOfFrames: 421
            property real frameRate: 30.0

            Image {
                id: slideShow
                anchors.fill: parent
                visible: false
                property string currentImageString: parent.currentImage
                source: parent.imagePath + "0".repeat(parent.maxDigits - currentImageString.length) + currentImageString + parent.imageType
            }
            BrightnessContrast {
                id: contrastCorrectedVideo
                anchors.fill: slideShow
                source: slideShow
                brightness: -0.045
                contrast: 0.065
            }
            Timer {
                id: timer
                repeat: true
                interval: 1000.0 / parent.frameRate
                onTriggered: {
                    if (parent.currentImage >= parent.numberOfFrames) parent.currentImage = 1
                    else ++parent.currentImage
                }
            }

            function play() {
               timer.start()
            }
            function stop() {
                timer.stop()
            }
        }/*/

        property bool videoShouldRun: false
        property bool videoLoaded: false
        function play() {
           videoShouldRun = true
        }
        function stop() {
           videoShouldRun = false
        }
        function load() {
           videoLoaded = true
           runningVideo.autoLoad = true
        }
        function manageVideo() {
           if (videoShouldRun && videoLoaded) {
               runningVideo.seek(0)
               runningVideo.play()
           } else {
               runningVideo.stop()
               runningVideo.seek(0)
           }
        }
        onVideoShouldRunChanged: manageVideo()
        onVideoLoadedChanged: manageVideo()

        Image {
            id: backgroundImage
            anchors.fill: parent
            source: program.definition.runningImage
            visible: program.definition.runningImage
        }

        MediaPlayer {
            id: runningVideo
            source: program.definition.runningVideo
            loops: MediaPlayer.Infinite
            autoLoad: false
        }
        VideoOutput {
            id: video
            visible: false
            anchors.fill: parent
            source: runningVideo
        }
        BrightnessContrast {
            id: contrastCorrectedVideo
            anchors.fill: video
            source: video
            brightness: -0.085
            contrast: 0.115
            opacity: (runningVideo.position > 0 && runningVideo.position < runningVideo.duration - 1500) ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: 1000
                }
            }
        }
    }
    background: ShaderEffectSource {
        anchors.fill: parent
        sourceItem: bgVideo
        hideSource: true
    }

    content: Item {
        id: contentItem

        // Program title line
        TextLabel {
            id: programTitle
            anchors.top: parent.top
            anchors.topMargin: 11
            anchors.left: parent.left
            RunningScreenAnimation {
                id: programTitleProgress
                delay: 0
                animationTime: pushEnterTime * 20.0 / 30.0
                animationPrimed: runFlyInAnimation
            }
            anchors.leftMargin: 25 + (1.0 - programTitleProgress.value) * parent.width * 0.5
            opacity: programTitleProgress.value
            anchors.right: parent.right
            anchors.rightMargin: 25
            fontPixelSize: constants.smallTitleTextSize
            color: themedLightContrastColor
            text: program.definition.name
            doElide: true
        }

        Row {
            id: configLine
            anchors.left: parent.left
            anchors.leftMargin: 36
            anchors.verticalCenter: programTitle.baseline
            anchors.verticalCenterOffset: 64
            spacing: 0
            add: Transition {
                 NumberAnimation {
                     property: "opacity"
                     duration: 300
                     from: 0
                     to: 1
                     easing.type: Easing.Linear
                 }
             }
            move: Transition {
                NumberAnimation {
                    property: "x"
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }

            readonly property real animationStartStart: 0.07
            readonly property real animationStartFactor: 0.27
            readonly property real animationTime: 0.7
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram
                sourceComponent: ConfigInfoButton {
                    id: temperature

                    RunningScreenAnimation {
                        id: temperaturePushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * temperature.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - temperaturePushProgress.value)
                    opacity: temperaturePushProgress.value
                    iconSource: "file:resources/siemens/icons/temperature_small.png"
                    progressValue: preHeatingProgress < 1 || preHeatingMessageQueued ?  Math.floor(backend.currentTemperature) : ""
                    value: preHeatingProgress < 1 || preHeatingMessageQueued ?  program.definition.temperature.value() : Math.floor(backend.currentTemperature)
                    valueColor: 'white'
                    unit: "°C"
                    fontPixelSize: constants.runningSmallConfigTextSize
                    unitOnTop: true
                    isEnabled: program.definition.temperature.isEnabled
                    onClicked: {
                        modalOverlay.open(boxInput.temperatureOption)
                    }
                    isDeactivated: false

                    hasProgressBar: preHeatingProgress < 1 || preHeatingMessageQueued
                    progress: preHeatingProgress
                    hasSeparator: false
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram && !program.definition.quickHeat.isDeactivated && (preHeatingProgress < 1 || preHeatingMessageQueued)
                sourceComponent: ConfigInfoButton {
                    id: quickHeat
                    RunningScreenAnimation {
                        id: quickHeatPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * parent.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - quickHeatPushProgress.value)
                    opacity: quickHeatPushProgress.value
                    iconSource: "file:resources/siemens/icons/icn_schnellaufheizen_running.png"
                    value: program.definition.quickHeat.isEnabled ? "ein" : "aus"
                    valueColor: 'white'
                    fontPixelSize: constants.runningSmallConfigTextSize
                    isEnabled: program.definition.quickHeat.isEnabled
                    isDeactivated: program.definition.quickHeat.isDeactivated
                    state: preHeatingProgress < 1 || preHeatingMessageQueued ? "" : "disabled"
                    onClicked: program.definition.quickHeat.isEnabled = !program.definition.quickHeat.isEnabled
                    onIsDeactivatedChanged: {
                        if (isDeactivated && isEnabled && display.currentItem === root) {
                            footer.infoBubble.show({"value": "Schnellaufheizen deaktiviert", "iconSource": "file:resources/siemens/icons/icn_schnellaufheizen_running.png"})
                        }
                    }
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram && (program.definition.steam.isEnabled || program.definition.steam.isInAlternativeMode) && !program.definition.steam.isDeactivated
                sourceComponent: ConfigInfoButton {
                    id: steam
                    RunningScreenAnimation {
                        id: steamPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * steam.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - steamPushProgress.value)
                    opacity: steamPushProgress.value
                    property bool isManual: program.definition.steam.isInAlternativeMode && !isDeactivated
                    iconSource: "file:resources/siemens/icons/icn_dampfzugabe_running.png"
                    value: isManual ? "Dampfstoß" : (program.definition.steam.isEnabled ? program.definition.steam.options[program.definition.steam.currentIndex] : "aus")
                    valueColor: (isManual && progress < 1.0) ? constants.inactiveColor : 'white'
                    fontPixelSize: constants.runningSmallConfigTextSize
                    isEnabled: program.definition.steam.isEnabled || isManual
                    isDeactivated: program.definition.steam.isDeactivated
                    onClicked: {
                        if (isManual) {
                            if (progress >= 1.0) progress = 0
                        } else modalOverlay.open(boxInput.steamOption)
                    }
                    onIsDeactivatedChanged: {
                        if (isDeactivated && (isEnabled || program.definition.steam.isInAlternativeMode) && display.currentItem === root) {
                            footer.infoBubble.show({"value": "Dampfzugabe deaktiviert", "iconSource": "file:resources/siemens/icons/icn_dampfzugabe_running.png"})
                        }
                    }
                    hasProgressBar: isManual
                    progress: 0
                    Timer {
                        interval: 100
                        running: steam.isManual
                        repeat: true
                        onTriggered: steam.progress = Math.min(1.0, steam.progress + 0.01)
                    }
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: program.definition.isCleaningProgram
                sourceComponent: ConfigInfoButton {
                    id: cleaningLevel
                    RunningScreenAnimation {
                        id: cleaningPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * cleaningLevel.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - cleaningPushProgress.value)
                    opacity: cleaningPushProgress.value
                    iconSource: "file:resources/siemens/icons/reinigung.png"
                    value: program.definition.cleaningLevel.options[program.definition.cleaningLevel.currentIndex]
                    valueColor: 'white'
                    fontPixelSize: constants.runningSmallConfigTextSize
                    isEnabled: program.definition.cleaningLevel.isEnabled
                    isDeactivated: program.definition.cleaningLevel.isDeactivated
                    onClicked: modalOverlay.open(boxInput.cleaningLevelOption)
                    hasSeparator: false
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram && program.definition.microwave.isEnabled
                sourceComponent: ConfigInfoButton {
                    id: microwave
                    RunningScreenAnimation {
                        id: microwavePushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * microwave.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - microwavePushProgress.value)
                    opacity: microwavePushProgress.value
                    iconSource: "file:resources/siemens/icons/icn_mikrowelle_running.png"
                    value: program.definition.microwave.isEnabled ? program.definition.microwave.options[program.definition.microwave.currentIndex] : "aus"
                    valueColor: 'white'
                    fontPixelSize: constants.runningSmallConfigTextSize
                    unitOnTop: true
                    unit: program.definition.microwave.isEnabled ? "W" : ""
                    isEnabled: program.definition.microwave.isEnabled
                    isDeactivated: program.definition.microwave.isDeactivated
                    onClicked: {
                        modalOverlay.open(boxInput.microwaveOption)
                    }
                    onIsDeactivatedChanged: {
                        if (isDeactivated && isEnabled && display.currentItem === root) {
                            footer.infoBubble.show({"value": "Mikrowelle deaktiviert", "iconSource": "file:resources/siemens/icons/icn_mikrowelle_running.png"})
                        }
                    }
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram && program.definition.thermometer.isEnabled
                sourceComponent: ConfigInfoButton {
                    id: thermometer
                    RunningScreenAnimation {
                        id: thermometerPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * thermometer.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - thermometerPushProgress.value)
                    opacity: thermometerPushProgress.value
                    iconSource: "file:resources/siemens/icons/icn_bratenthermometer_running.png"
                    value: program.definition.thermometer.isEnabled ? program.definition.thermometer.value() : "aus"
                    valueColor: 'white'
                    fontPixelSize: constants.runningSmallConfigTextSize
                    unitOnTop: true
                    unit: program.definition.thermometer.isEnabled ? "°C" : ""
                    isEnabled: program.definition.thermometer.isEnabled
                    isDeactivated: program.definition.thermometer.isDeactivated
                    onClicked: {
                        modalOverlay.open(boxInput.cleaningLevelOption)
                    }
                    onIsDeactivatedChanged: {
                        if (isDeactivated && isEnabled && display.currentItem === root) {
                            footer.infoBubble.show({"value": "Bratenthermometer deaktiviert", "iconSource": "file:resources/siemens/icons/icn_bratenthermometer_running.png"})
                        }
                    }
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: !program.definition.isMeal && !program.definition.isCleaningProgram
                sourceComponent: ConfigInfoButton {
                    id: add
                    RunningScreenAnimation {
                        id: addPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * add.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - addPushProgress.value)
                    opacity: addPushProgress.value
                    iconSource: "file:resources/siemens/icons/add.png"
                    isEnabled: false
                    isDeactivated: false
                    iconColor: "white"
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: program.definition.isMeal && program.definition.weightToDuration.isEnabled
                sourceComponent: ConfigInfoButton {
                    id: weight
                    RunningScreenAnimation {
                        id: weightPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * weight.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - weightPushProgress.value)
                    opacity: weightPushProgress.value
                    iconSource: "file:resources/siemens/icons/gewicht.png"
                    value: program.definition.weightToDuration ? program.definition.weightToDuration.value() : ""
                    valueColor: themedLightContrastColor
                    unit: "g"
                    fontPixelSize: constants.runningSmallConfigTextSize
                    unitOnTop: false
                    isEnabled: program.definition.weightToDuration ? program.definition.weightToDuration.isEnabled : false
                    isDeactivated: program.definition.weightToDuration ? program.definition.weightToDuration.isDeactivated : true
                    hasSeparator: false
                }
            }
            Loader {
                anchors.verticalCenter: parent.verticalCenter
                visible: active
                active: program.definition.isMeal
                sourceComponent: Row {
                    id: preparationLabel
                    RunningScreenAnimation {
                        id: preparationPushProgress
                        delay: pushEnterTime * (configLine.animationStartStart + configLine.animationStartFactor * preparationLabel.parent.x / configLine.width)
                        animationTime: pushEnterTime * configLine.animationTime
                        animationPrimed: runFlyInAnimation
                    }
                    x: root.width * 0.5 * (1.0 - preparationPushProgress.value)
                    opacity: preparationPushProgress.value
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 24

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "file:resources/siemens/icons/separator.png"
                        width: approximateInNativeResolution(implicitWidth)
                    }
                    Icon {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "file:resources/siemens/icons/icn_dampfzugabe_running.png"
                        color: themedLightContrastColor
                        visible: program.definition.steam && program.definition.steam.isEnabled
                    }
                    Icon {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "file:resources/siemens/icons/icn_mikrowelle_running.png"
                        color: themedLightContrastColor
                        visible: program.definition.microwave && program.definition.microwave.isEnabled
                    }
                    Icon {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "file:resources/siemens/icons/icn_bratenthermometer_running.png"
                        color: themedLightContrastColor
                        visible: program.definition.thermometer && program.definition.thermometer.isEnabled
                    }
                }
            }
        }

        // Remaining time label
        TextLabel {
            id: remainingTimeLabel
            anchors.left: remainingTimeValue.left
            anchors.leftMargin: -4
            anchors.bottom: parent.bottom
            RunningScreenAnimation {
                id: remainingTimeLabelPushProgress
                delay: pushEnterTime * 0.285
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.bottomMargin: 109 * remainingTimeLabelPushProgress.value
            opacity: remainingTimeLabelPushProgress.value
            text: "Dauer"
            color:themedLightContrastColor
            fontPixelSize: constants.runningDescriptionTextSize
        }

        ConfigString {
            id: remainingTimeValue
            property string remainingHours: getHours(remainingTime)
            property string remainingMinutes:getMinutes(remainingTime)
            property string remainingSeconds: getSeconds(remainingTime)
            anchors.verticalCenter: parent.bottom
            RunningScreenAnimation {
                id: remainingTimeValueProgress
                delay: pushEnterTime * 0.43
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.verticalCenterOffset: -63 * remainingTimeValueProgress.value
            opacity: remainingTimeValueProgress.value
            anchors.left: parent.left
            anchors.leftMargin: 25
            iconSource: "file:resources/siemens/icons/icn_dauer_running.png"
            iconColor: remainingTime >= 0 ? constants.defaultBlue : themedStrongContrastColor
            value: remainingTime >= 0 ? timeString(remainingHours > 0 ? remainingHours : remainingMinutes) : "--"
            unit: remainingHours > 0 ? "h" : "min"
            valueSecondary: remainingTime >= 0 ? timeString(remainingHours > 0 ? remainingMinutes : remainingSeconds) : "--"
            unitSecondary: remainingHours > 0 ? "min" : "s"
            separatorString: " "
            unitOnTop: false
            valueColor: program.isMeal || program.definition.isCleaningProgram ? themedLightContrastColor : themedStrongContrastColor
            textSize: constants.runningBigConfigTextSize
        }
        MouseArea {
            enabled: !program.definition.isCleaningProgram
            anchors.centerIn: remainingTimeValue
            width: remainingTimeValue.width + 50
            height: remainingTimeValue.height + 50
            onClicked: modalOverlay.open(boxInput.remainingTimeOption)
        }

        // RunningTime
        TextLabel {
            id: runningTimeLabel
            anchors.left: runningTimeValue.left
            anchors.leftMargin: -4
            anchors.bottom: parent.bottom
            RunningScreenAnimation {
                id: runningTimeLabelPushProgress
                delay: pushEnterTime * 0.285
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.bottomMargin: 109 * runningTimeLabelPushProgress.value
            opacity: runningTimeLabelPushProgress.value
            text: "Laufzeit"
            color: themedLightContrastColor
            fontPixelSize: constants.runningDescriptionTextSize
            visible: remainingTime < 0
        }
        ConfigString {
            id: runningTimeValue
            property int elapsedHours: getHours(elapsedTime)
            property int elapsedMinutes: getMinutes(elapsedTime)
            property int elapsedSeconds: getSeconds(elapsedTime)
            anchors.verticalCenter: parent.bottom
            RunningScreenAnimation {
                id: runningTimeValuePushProgress
                delay: pushEnterTime * 0.43
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.verticalCenterOffset: -63 * runningTimeValuePushProgress.value
            opacity: runningTimeValuePushProgress.value
            anchors.left: parent.right
            anchors.leftMargin: -315
            iconSource: "file:resources/siemens/icons/icn_laufzeit_running.png"
            iconColor: themedLightContrastColor
            value: timeString(elapsedHours > 0 ? elapsedHours : elapsedMinutes)
            unit: elapsedHours > 0 ? "h" : "min"
            valueSecondary: timeString(elapsedHours > 0 ? elapsedMinutes : elapsedSeconds)
            unitSecondary: elapsedHours > 0 ? "min" : "s"
            separatorString: " "
            unitOnTop: false
            valueColor: themedLightContrastColor
            textSize: constants.runningBigConfigTextSize
            visible: remainingTime < 0
        }

        // Ends at
        TextLabel {
            id: endTimeLabel
            anchors.left: endTimeValue.left
            anchors.leftMargin: -4
            anchors.bottom: parent.bottom
            RunningScreenAnimation {
                id: endTimeLabelPushProgress
                delay: pushEnterTime * 0.285
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.bottomMargin: 109 * endTimeLabelPushProgress.value
            opacity: endTimeLabelPushProgress.value
            text: "Fertig um"
            color: themedLightContrastColor
            fontPixelSize: constants.runningDescriptionTextSize
            visible: remainingTime >= 0
        }
        ConfigString {
            id: endTimeValue
            anchors.verticalCenter: parent.bottom
            RunningScreenAnimation {
                id: endTimeValuePushProgress
                delay: pushEnterTime * 0.43
                animationTime: pushEnterTime * 1.0
                animationPrimed: runFlyInAnimation
            }
            anchors.verticalCenterOffset: -63 * endTimeValuePushProgress.value
            opacity: endTimeValuePushProgress.value
            anchors.left: parent.right
            anchors.leftMargin: -243
            iconSource: "file:resources/siemens/icons/icn_endet_um.png"
            iconColor: constants.defaultBlue
            value: timeString(getHours(remainingTime + waitingTime + backend.wallClock) % 24)
            valueSecondary: timeString(getMinutes(remainingTime + waitingTime + backend.wallClock))
            separatorString: ":"
            unitOnTop: false
            valueColor: themedLightContrastColor
            textSize: constants.runningBigConfigTextSize
            visible: remainingTime >= 0
        }

        ProgressBar {
            id: progressBar
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 6
            anchors.left: parent.left
            anchors.right: parent.right
            height: 11
            property real progress: elapsedTime  / (elapsedTime + remainingTime)
            value: progress > 1 ? 0 : progress
            Behavior on value {
                NumberAnimation {
                    duration: 1000
                }
            }
            RunningScreenAnimation {
                id: progressBarPushProgress
                delay: pushEnterTime * 0.7
                animationTime: pushEnterTime * 1.0
                easingType: Easing.Linear
                animationPrimed: runFlyInAnimation
            }
            opacity: progressBarPushProgress.value

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
        actionButtonText: qsTr("Stop")
        onAction: function () {
            program.terminate();
            display.pop()
        }

        IconButton {
            id: lightButton
            anchors.verticalCenter: footer.infoButton.verticalCenter
            anchors.verticalCenterOffset: 4
            anchors.left: footer.infoButton.right
            width: 96
            height: 96
            source: "file:resources/siemens/icons/light_on.png"
            color: themedStrongContrastColor
        }
    }
}
