import QtQuick 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import QtQuick.Particles 2.0

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Example")

    property int columnFactor: 5

    GridLayout {
        rowSpacing: 12
        columnSpacing: 30
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 30

        TabView {
            Layout.row: 6
            Layout.columnSpan: 3
            Layout.fillWidth: true
            implicitHeight: 30
            Tab { title: "One" ; Item {}}
            Tab { title: "Two" ; Item {}}
            Tab { title: "Three" ; Item {}}
            Tab { title: "Four" ; Item {}}
            Tab { title: "Five" ; Item {}}
            style: tabViewStyle
        }

        TextField {
            Layout.row: 1
            implicitWidth: window.width / columnFactor
        }
        TextField {
            style: TextFieldStyle {
                background: BorderImage {
                    source: "images/textfield.png"
                    border.left: 4 ; border.right: 4 ; border.top: 4 ; border.bottom: 4
                }
            }
            implicitWidth: window.width / columnFactor
        }
        TextField {
            style: textFieldStyle
            implicitWidth: window.width / columnFactor
        }

        Slider {
            id: slider1
            Layout.row: 2
            value: 0.5
            implicitWidth: window.width / columnFactor
        }
        Slider {
            id: slider2
            value: 0.5
            implicitWidth: window.width / columnFactor
            style: SliderStyle {
                groove: BorderImage {
                    height: 6
                    border.top: 1
                    border.bottom: 1
                    source: "images/progress-background.png"
                    border.left: 6
                    border.right: 6
                    BorderImage {
                        anchors.verticalCenter: parent.verticalCenter
                        source: "images/progress-fill.png"
                        border.left: 5 ; border.top: 1
                        border.right: 5 ; border.bottom: 1
                        width: styleData.handlePosition
                        height: parent.height
                    }
                }
                handle: Item {
                    width: 13
                    height: 13
                    Image {
                        anchors.centerIn: parent
                        source: "images/slider-handle.png"
                    }
                }
            }
        }
        Slider {
            id: slider3
            value: 0.5
            implicitWidth: window.width / columnFactor
            style: sliderStyle
        }

        ProgressBar {
            Layout.row: 3
            value: slider1.value
            implicitWidth: window.width / columnFactor
        }
        ProgressBar {
            value: slider2.value
            implicitWidth: window.width / columnFactor
            style: progressBarStyle
        }
        ProgressBar {
            value: slider3.value
            implicitWidth: window.width / columnFactor
            style: progressBarStyle2
        }
    }

    Component {
        id: tabViewStyle
        TabViewStyle {
            tabOverlap: 16
            frameOverlap: 4
            tabsMovable: true

            frame: Rectangle {
                gradient: Gradient {
                    GradientStop { color: "#e5e5e5" ; position: 0 }
                    GradientStop { color: "#e0e0e0" ; position: 1 }
                }
                border.color: "#898989"
                Rectangle { anchors.fill: parent ; anchors.margins: 1 ; border.color: "white" ; color: "transparent" }
            }
            tab: Item {
                property int totalOverlap: tabOverlap * (control.count - 1)
                implicitWidth: Math.min ((styleData.availableWidth + totalOverlap)/control.count - 4, image.sourceSize.width)
                implicitHeight: image.sourceSize.height
                BorderImage {
                    id: image
                    anchors.fill: parent
                    source: styleData.selected ? "images/tab_selected.png" : "images/tab.png"
                    border.left: 30
                    smooth: false
                    border.right: 30
                }
                Text {
                    text: styleData.title
                    anchors.centerIn: parent
                }
            }
            leftCorner: Item { implicitWidth: 12 }
        }
    }
    Component {
        id: textFieldStyle
        TextFieldStyle {
            background: Rectangle {
                implicitWidth: window.width / columnFactor
                color: "#f0f0f0"
                antialiasing: true
                border.color: "gray"
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#aaffffff"
                    radius: height/2
                }
            }
        }
    }

    Component {
        id: sliderStyle
        SliderStyle {
            handle: Rectangle {
                width: 18
                height: 18
                color: control.pressed ? "darkGray" : "lightGray"
                border.color: "gray"
                antialiasing: true
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#eee"
                    radius: height/2
                }
            }

            groove: Rectangle {
                height: 8
                implicitWidth: window.width / columnFactor
                implicitHeight: 22

                antialiasing: true
                color: "#ccc"
                border.color: "#777"
                radius: height/2
                Rectangle {
                    anchors.fill: parent
                    anchors.margins: 1
                    color: "transparent"
                    antialiasing: true
                    border.color: "#66ffffff"
                    radius: height/2
                }
            }
        }
    }

    Component {
        id: progressBarStyle
        ProgressBarStyle {
            background: BorderImage {
                source: "images/progress-background.png"
                border.left: 2 ; border.right: 2 ; border.top: 2 ; border.bottom: 2
            }
            progress: Item {
                clip: true
                BorderImage {
                    anchors.fill: parent
                    anchors.rightMargin: (control.value < control.maximumValue) ? -4 : 0
                    source: "images/progress-fill.png"
                    border.left: 10 ; border.right: 10
                    Rectangle {
                        width: 1
                        color: "#a70"
                        opacity: 0.8
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 1
                        anchors.right: parent.right
                        visible: control.value < control.maximumValue
                        anchors.rightMargin: -parent.anchors.rightMargin
                    }
                }
                ParticleSystem { id: bubbles; running: visible }
                ImageParticle {
                    id: fireball
                    system: bubbles
                    source: "images/bubble.png"
                    opacity: 0.7
                }
                Emitter {
                    system: bubbles
                    anchors.bottom: parent.bottom
                    anchors.margins: 4
                    anchors.bottomMargin: -4
                    anchors.left: parent.left
                    anchors.right: parent.right
                    size: 4
                    sizeVariation: 4
                    acceleration: PointDirection { y: -6; xVariation: 3 }
                    emitRate: 6 * control.value
                    lifeSpan: 3000
                }
            }
        }
    }

    Component {
        id: progressBarStyle2
        ProgressBarStyle {
            background: Rectangle {
                implicitWidth: window.width / columnFactor
                implicitHeight: 24
                color: "#f0f0f0"
                border.color: "gray"
            }
            progress: Rectangle {
                color: "#ccc"
                border.color: "gray"
                Rectangle {
                    color: "transparent"
                    border.color: "#44ffffff"
                    anchors.fill: parent
                    anchors.margins: 1
                }
            }
        }
    }
}
