import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import QtMultimedia 5.12
import bsh.backend 1.0

ApplicationWindow {
    id: clickDummy
    title: qsTr("WASHING")
    visible: true
//    Width: 527
//    Height: 296
    color: "#303030"
    // Part of a workaround to get the window fullscreen on the active monitor.
    visibility: Window.Minimized

    // C++ Interfacing
    readonly property double mm: _mm
    property real xShift: _xShift
    property real yShift: _yShift
    readonly property double uiScale: _uiScale
    EOX6021BackEnd { id: backend }

    // Instantiate the program configurations.
    // These should be loaded from a config file within the backend in an embedded implementation.
    OvenPrograms { id: ovenPrograms }
    BreadPrograms { id: breadPrograms }
    FavoritePrograms { id: favorites }
    CleaningPrograms{ id: cleaningPrograms }

    SoundEffect {
        id: sound_machine_on
        source: "file:resources/siemens/sounds/EOX6021_BRANDx_SID29_Switch_On.wav"
    }
    SoundEffect {
        id: sound_machine_off
        source: "file:resources/siemens/sounds/EOX6021_BRANDx_SID2A_Switch_Off.wav"
    }
    SoundEffect {
        id: sound_cook_advice
        source: "file:resources/siemens/sounds/EOX6021_BRANDx_SID27_Advice.wav"
    }
    SoundEffect {
        id: sound_cook_end
        source: "file:resources/siemens/sounds/EOX6021_BRANDx_SID24_End_of_Cook_Timer.wav"
    }

    EOX6021ProgramDefinition {
        id: microwaveProgram
        name: qsTr("Mikrowelle")
        isMicrowaveProgram: true
        microwave: ProgramIntegerOption {
            currentIndex: 2
            options: [90, 180, 360, 600, 900]
            isEnabled: true
        }

        duration: ProgramIntegerIntervalOption {
            startingValue: 5
            intervalLength: 5
            intervalCount: 90 * 12 - 1
            intervalIndex: 11
            isEnabled: true
        }
        runningImage: "file:resources/siemens/images/BG_microwave.png"
    }

    Component.onCompleted: {
        // Part of a workaround to get the window fullscreen on the active monitor.
        visibility = Window.Windowed
        visibility = AutomaticVisibility//Window.FullScreen

        backend.setAlarmIndex(0)

        // Add the program defintions to the backend.
        backend.ovenPrograms = ovenPrograms
        backend.favorites = favorites
        backend.breadPrograms = breadPrograms
        backend.microwaveProgram = microwaveProgram
        backend.cleaningPrograms = cleaningPrograms

        redrawWorkaround.y = 1
        redrawWorkaround.y = 0
        standbyScreen.content.opacity = 1
    }

    // Preloading images uses more memory but might reduce load lag benefiting animations
    /*ImagePreloader {
        folder: "file:resources/siemens/"
        asynchronous: false
        onLoaded: standbyScreen.content.opacity = 1
    }*/

    // Temporary location for library functions
    function getHhMmFromSeconds(seconds) {
        var rawHours = getHours(seconds)
        var minutes = getMinutes(seconds)
        var hours = rawHours % 24
        return timeString(hours) + ":" + timeString(minutes)
    }

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

    function approximateInNativeResolution(value, minValue) {
        return Math.max((minValue !== undefined) ? minValue : 1, Math.round(value * uiScale)) / uiScale
    }

    // Global constants and variables
    TextMetrics {
        id: baseTextMetrics
        font.pixelSize: 10000
        text: "X"
    }
    QtObject {
        id: constants

        // Scale from capital letter height to font size.
        readonly property real fontCapitalHeightScaling: baseTextMetrics.font.pixelSize / baseTextMetrics.tightBoundingRect.height
        readonly property real fontLetterSpacing: 0

        readonly property real displayWidth: 1280
        readonly property real displayHeight: 544

        readonly property real imageTileWidth: 303
        readonly property real imageTileHeight: 424
        readonly property real overviewTileWidth: 274
        readonly property real overviewTileHeight: 261
        readonly property real openedConfigTileWidth: 772
        readonly property real programTileWidth: 274
        readonly property real programTileHeight: 261

        readonly property real smallTitleTextSize: 45.9
        readonly property real largeTitleTextSize: 55
        readonly property real descriptionTextSize: 34
        readonly property real optionTileTextSize: 50
        readonly property real headerTextSize: 38
        readonly property real runningSmallConfigTextSize: 38
        readonly property real runningBigConfigTextSize: 58
        readonly property real runningDescriptionTextSize: 33.77
        readonly property real textSizeF1: 34
        readonly property real textSizeF4: 38
        readonly property real textSizeF5: 58
        readonly property real textSizeF6: 46
        readonly property real textSizeF10: 50
        readonly property real textSizeF11: 55
        readonly property real textSizeF12: 29

        readonly property color defaultBlue: "#2d73ff"
        readonly property color highlightBlue: "#27b9fe"
        readonly property color inactiveColor: "#88bbbbbb"
        readonly property color settingsInactiveColor: "#bbbbbb"
        readonly property color fadedInactiveColor: "#003e4759"
        readonly property color scrollBarColor: "#3e4759"
        readonly property color lightFavoriteTileTextColor: "#bbbbbb"
        readonly property color blueThemeLightContrast: "#96b0d6"
        readonly property color blueThemeStrongContrast: "#ffffff"
    }
    property color themedStrongContrastColor: constants.blueThemeStrongContrast
    property color themedLightContrastColor: constants.blueThemeLightContrast

    // Main focus area
    MouseArea {
        id: keyCatch
        focus: true
        anchors.fill: parent

        // Workaround for bugged redraw by the windowing system on tabbing
        Item {
            id: redrawWorkaround
        }
        onActiveFocusChanged: {
            redrawWorkaround.y=1
            redrawWorkaround.y=0
        }

        // Application options using keyboard and mouse
        function printCanvasPosition() {
            console.log("Canvas position:","(" + xShift.toString() + ", " + yShift.toString() + ")")
        }
        Keys.onPressed: {
            switch (event.key) {
            case Qt.Key_Escape:
                clickDummy.close()
                break
            case Qt.Key_F1:
                clickDummy.visibility = (clickDummy.visibility === Window.Windowed) ? Window.FullScreen : Window.Windowed
                break
            case Qt.Key_Space:
                backend.fastForward()
                break
            case Qt.Key_Left:
                xShift -= 1.0
                printCanvasPosition()
                break
            case Qt.Key_Right:
                xShift += 1.0
                printCanvasPosition()
                break
            case Qt.Key_Down:
                yShift += 1.0
                printCanvasPosition()
                break
            case Qt.Key_Up:
                yShift -= 1.0
                printCanvasPosition()
                break
            }
        }

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton)
            {
                // Allow direct click away of menu using left mouse button.
                clickDummyMenu.x = mouse.x + 1
                clickDummyMenu.y = mouse.y + 1
                clickDummyMenu.open()
            } else {
                backend.fastForward()
            }
        }
        Menu {
            id: clickDummyMenu
            MenuItem {
                text: qsTr("Close")
                onTriggered: clickDummy.close()
            }
            MenuItem {
                text: qsTr("Windowed")
                onTriggered: clickDummy.visibility = Window.Windowed
            }
            MenuItem {
                text: qsTr("FullScreen")
                onTriggered: clickDummy.visibility = Window.FullScreen
            }
        }

        // Virtual machine
        Item {
            scale: uiScale
            x: xShift
            y: yShift
            width: parent.width
            height: parent.height

            // Front panel
            Image
            {
                id: frontPanel
                anchors.top: parent.top
                anchors.topMargin: display.y - 16.5 * mm
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
                width: 600 * mm
                source: "file:resources/siemens/images/QT_Blende.png"

                // Prevent the front panel from triggering background press actions
                MouseArea {
                    anchors.fill: parent
                }
            }

            // Front Panel Buttons
            MouseArea {
                id: onOffButton
                width: onOffIcon.width
                height: onOffIcon.height + 10 * mm
                anchors.right: display.left
                anchors.rightMargin: 448
                y: display.y + display.height - height - 30 + 5 * mm
                Icon {
                    id: onOffIcon
                    anchors.centerIn: parent
                    source: "file:resources/siemens/icons/2_icn_on-off.png"
                    color: display.depth <= 1 ? "#ffffff" : constants.defaultBlue
                }

                onPressed: {
                    if(display.depth <= 1) {
                        sound_machine_on.play()
                        display.push("HomeScreen.qml")
                    } else {
                        sound_machine_off.play()
                        keyboardOverlay.terminate()
                        settingsOverlay.terminate()
                        modalOverlay.terminate()
                        display.pop(null)
                    }
                }

                Connections {
                    target: display
                    onDepthChanged: if (display.depth <= 1) backend.turnOff()
                }
            }
            Icon {
                anchors.verticalCenter: onOffButton.verticalCenter
                anchors.right: display.left
                anchors.rightMargin: 313
                source: "file:resources/siemens/icons/icn_front_heat.png"
                width: height * implicitWidth / implicitHeight
                height: 43
                color: "#ffffff"
            }
            Icon {
                anchors.verticalCenter: onOffButton.verticalCenter
                anchors.left: display.right
                anchors.leftMargin: 315
                source: "file:resources/siemens/icons/icn_front_bell.png"
                width: height * implicitWidth / implicitHeight
                height: 43
                color: "#ffffff"
            }
            Icon {
                anchors.verticalCenter: onOffButton.verticalCenter
                anchors.left: display.right
                anchors.leftMargin: 475
                source: "file:resources/siemens/icons/icn_front_key.png"
                width: height * implicitWidth / implicitHeight
                height: 33
                color: "#ffffff"
            }
            Icon {
                anchors.verticalCenter: onOffButton.verticalCenter
                anchors.left: display.right
                anchors.leftMargin: 652
                source: "file:resources/siemens/icons/icn_front_oven.png"
                width: height * implicitWidth / implicitHeight
                height: 45
                color: "#ffffff"
            }

            // The enmulated display
            StackView {
                id: display
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: constants.displayWidth
                height: constants.displayHeight

                background: Rectangle {
                    anchors.fill: display
                    color: "#111111"
                }

                // Call enter animations by script asynchronously to allow clicks before full load/fade-in
                popEnter: Transition {
                    id: popEnter
                    ScriptAction {
                        script: {
                            popEnter.ViewTransition.item.popEnterAnimation.start()
                        }
                    }
                }
                pushEnter: Transition {
                    id: pushEnter
                    ScriptAction {
                        script: pushEnter.ViewTransition.item.pushEnterAnimation.start()
                    }
                }

                popExit: Transition {
                    animations: ViewTransition.item.popExitAnimation
                }
                pushExit: Transition {
                    animations: ViewTransition.item.pushExitAnimation
                }

                initialItem: StandbyScreen {
                    id: standbyScreen
                }
            }
            Item {
                anchors.fill: display
                SettingsOverlay {
                    id: settingsOverlay
                }
            }
            ModalOverlayStack {
                id: modalOverlay
                anchors.fill: display
            }
            Item {
                anchors.fill: display
                KeyboardOverlay {
                    id: keyboardOverlay
                }
            }
        }
    }
}
