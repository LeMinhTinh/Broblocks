import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Window 2.11
import QtGraphicalEffects 1.0
import bsh.eox6021 1.0

ApplicationWindow {
    id: clickDummy
    title: qsTr("WASHING")
    visible: true
    color: "#303030"
    
    property var date: new Date()
    Timer{
        interval: 999
        repeat: true
        running: true
        onTriggered: {
            clickDummy.date=new Date()
        }
    }

    // C++ Interfacing
    readonly property double mm: _mm
    EOX6021BackEnd {
        id: backend
    }

    // Instatiate the program configurations.
    // These should be loaded from a config file within the backend for the embedded implementation.
    OvenPrograms {
        id: ovenPrograms
    }
    FavoritePrograms {
        id: favorites
    }

    // Workaround to get the window fullscreen on the active monitor.
    visibility: Window.Minimized

    Component.onCompleted: {
        visibility = Window.Windowed
        visibility = Window.AutomaticVisibility//Window.FullScreen

        // Add the program defintions to the backend.
        backend.ovenPrograms = ovenPrograms
        backend.favorites = favorites

        redrawWorkaround.y = 1
        redrawWorkaround.y = 0
        standbyScreen.content.opacity = 1

    }

    function toggleWindow() {
        if (clickDummy.visibility == Window.Windowed) {
            clickDummy.visibility = Window.FullScreen
        } else {
            clickDummy.visibility = Window.Windowed
        }
    }

    // Temporary location for library functions
    function getHhMmFromSeconds(seconds) {
        var rawHours = Math.floor(seconds / 3600)
        var minutes = Math.floor((seconds - rawHours * 3600) / 60)
        var hours = rawHours % 24

        var hhmm = (hours < 10) ? "0" : ""
        hhmm += hours.toString()
        hhmm += (minutes < 10) ? ":0" : ":"
        hhmm += minutes.toString()
        return hhmm
    }

    // Global constants
    TextMetrics {
        id: baseTextMetrics
        font.pixelSize: 10000
        text: "X"
    }
    QtObject {
        id: constants

        // Scale from capital letter height to font size.
        readonly property real fontCapitalHeightScaling: 10000
                                                         / baseTextMetrics.tightBoundingRect.height

        readonly property int titleSize: 64
        readonly property int homeTileTextSize: 37
        readonly property int descriptionTextSize: 34
        readonly property int smallTitleSize: 46
        readonly property int optionTileTextSize: 55
        readonly property int mainTitleTextSize: 55
        readonly property int standbyScreenTextSize: 108
        readonly property int imageTileTextSize: 37

        readonly property color lightThemeLightContrast: "#5d5e62"
        readonly property color lightThemeStrongContrast: "#000000"
        readonly property color darkThemeLightContrast: "#bbbbbb"
        readonly property color darkThemeStrongContrast: "#ffffff"
        readonly property color blueThemeLightContrast: "#96b0d6"
        readonly property color blueThemeStrongContrast: "#ffffff"

        readonly property color defaultBlue: "#2d73ff"
        readonly property color highlightBlue: "#27b9fe" //"#28bbff"
        readonly property color inactiveColor: "#88bbbbbb" //"#3e4759"
        readonly property color fadedInactiveColor: "#003e4759"
        readonly property color scrollBarColor: "#3e4759"

        readonly property int overviewTileWidth: 274
        readonly property int openedConfigTileWidth: 772

        readonly property color lightFavoriteTileTextColor: "#bbbbbb"
    }

    // Default to dark theme
    property color themedStrongContrastColor: constants.blueThemeStrongContrast
    property color themedLightContrastColor: constants.blueThemeLightContrast

    // Main focus area
    MouseArea {
        id: keyCatch
        focus: true
        anchors.fill: parent
/*
        //        洗衣机模拟图
        Image {
            width: parent.width
            height: parent.height

            //                width: 600 * mm
            //                可以用左斜杠?
            source: "file:resources\\images\\washing.png"

            // Prevent the fron panel from triggering background press actions
            MouseArea {
                anchors.fill: parent
            }
        }
*/
        // Workaround for bugged redraw by the windowing system on tabbing
        Item {
            id: redrawWorkaround
        }
        onActiveFocusChanged: {
            redrawWorkaround.y = 1
            redrawWorkaround.y = 0
        }

        // Application options using keyboard and mouse
        Keys.onPressed: {
            switch (event.key) {
                //                Qt.quit()
            case Qt.Key_Escape:
                clickDummy.close()
                break
            case Qt.Key_F1:
                toggleWindow()
                break
            }
        }

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if (mouse.button === Qt.RightButton) {
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
                text: qsTr("Exit")
                onTriggered: Qt.quit()
            }
            MenuItem {
                text: qsTr("toggleWindow")
                onTriggered: toggleWindow()
            }
        }

        // Virtual oven
        Item {
            scale: uiScale
            anchors.fill: parent


            // 4个物理按钮
            Row {
                y: display.y + display.height + 5 * mm
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 50

                // Front Panel Buttons
                MouseArea {
                    id: onOffButton
                    width: onOffIcon.width
                    height: onOffIcon.height + 10 * mm
                    //                anchors.left: display.left
                    //                anchors.rightMargin: 448
                    //                    y: display.y + display.height + 5 * mm
                    Icon {
                        id: onOffIcon
                        anchors.centerIn: parent
                        source: "file:resources/icons/power.png"
                        color: "#ffffff"
                        height: 43
                        width:43
                    }

                    onPressed: state = (state === "enabled") ? "" : "enabled"
                    states: [
                        State {
                            name: "enabled"
                            PropertyChanges {
                                target: onOffIcon
                                color: constants.defaultBlue
                            }
                        }
                    ]
                    transitions: [
                        Transition {
                            to: "enabled"
                            ParallelAnimation {
                                ColorAnimation {
                                    target: onOffIcon
                                    duration: 250
                                    easing.type: Easing.Linear
                                }
                                ScriptAction {
                                    script: display.push("HomeScreen.qml")
                                }
                            }
                        },
                        //                        回到锁屏界面
                        Transition {
                            to: ""
                            ParallelAnimation {
                                ColorAnimation {
                                    target: onOffIcon
                                    duration: 125
                                    easing.type: Easing.Linear
                                }
                                ScriptAction {
                                    script: {
                                        backend.turnOff()
                                        display.pop(null)
                                    }
                                }
                            }
                        }
                    ]
                }
                Icon {
                    anchors.verticalCenter: onOffButton.verticalCenter
                    source: "file:resources/icons/up.png"
                    width: height
                    height: 43
                    color: "#ffffff"
                }
                Icon {
                    anchors.verticalCenter: onOffButton.verticalCenter
                    source: "file:resources/icons/down.png"
                    width: height
                    height: 43
                    color: "#ffffff"
                }
                Icon {
                    anchors.verticalCenter: onOffButton.verticalCenter
                    source: "file:resources/icons/exit.png"
                    height: 33
                    width:33
                    color: "#ffffff"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: clickDummy.close()
                    }
                }
            }

            // 主界面(框架)
            StackView {
                id: display
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                width: 1280
                height: 544

                //                width:1440
                //                height: 900
                background: Rectangle {
                    anchors.fill: display
                    color: "#0a0a0a"
                    border{
                        width: 1
                        color: 'white'
                    }
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
                KeyboardOverlay {
                    id: keyboardOverlay
                }
                QuestionOverlay {
                    id: questionOverlay
                }
                ModalOverlayBox {
                    id: modalOverlay
                }
            }
        }
    }


}
