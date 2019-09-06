import QtQuick 2.12
import QtQuick.Controls 2.12

BaseScreen
{
    id: root
    property int standbyClockMode: backend.standbyClockMode.currentIndex

    content: Item {
        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            anchors.bottomMargin: 13
            active: (standbyClockMode === 1) && root.StackView.visible
            sourceComponent: TextLabel {
                text: getHhMmFromSeconds(backend.wallClock)
                fontPixelSize: 90
                color: themedStrongContrastColor

                TextLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 25
                    text: backend.currentDate
                    fontPixelSize: 34
                    color: themedStrongContrastColor
                }
            }
        }

        Loader {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 70
            active: (standbyClockMode === 2) && root.StackView.visible
            sourceComponent: AnalogClock {
                seconds: backend.wallClock

                TextLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.bottom
                    anchors.topMargin: 25
                    text: backend.currentDate
                    fontPixelSize: 34
                    color: themedStrongContrastColor
                }
            }
        }

        Icon {
            id: wlanIcon
            source: "file:resources/siemens/icons/1_icn_wlan.png"
            anchors.right: parent.right
            anchors.rightMargin: 25
            anchors.top: parent.top
            anchors.topMargin: 32
            color: "#a2b5d6"
        }
    }
}
