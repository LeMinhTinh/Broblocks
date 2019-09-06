import QtQuick 2.12
import QtQuick.Controls 2.12
import bsh.backend 1.0

Item {
    id: root
    property var model
    property string title
    property bool runEntryAnimation: false

    ListView {
        id: settingsList
        anchors.fill: parent
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        spacing: 0
        flickableDirection: Flickable.VerticalFlick
        model: root.model

        opacity: runEntryAnimation ? 0 : 1
        property bool activateEntryAnimation: false
        Timer {
            running: root.runEntryAnimation
            onTriggered: {
                settingsList.activateEntryAnimation = true
                settingsList.opacity = 1.0
            }
            interval: 50
        }

        // TODO: this is a hack preventing reinstatiation and thus reanimation
        cacheBuffer: 10000
        delegate: Item {
            id: entryDelegate
            property real animationProgress: root.runEntryAnimation ? 0.0 : 1.0
            SequentialAnimation {
                running: settingsList.activateEntryAnimation
                PauseAnimation {
                    duration: index * 20
                }
                NumberAnimation {
                    target: entryDelegate
                    property: "animationProgress"
                    duration: 250
                    to: 1.0
                    easing.type: Easing.OutQuad
                }
            }
            property SettingsEntryModel menuItem: (index >= 0) ? settingsList.model.get(index) : null
            width: settingsList.width
            height: childrenRect.height
            opacity: animationProgress
            Rectangle {
                id: divider
                width: parent.width
                height: approximateInNativeResolution(1)
                color: "#646464"
                visible: index !== 0
            }
            Loader {
                id: entry
                width: parent.width
                Component.onCompleted: setSource(menuItem.target, menuItem.properties)
            }
        }

        ScrollBar.vertical: ScrollBar {
            width: approximateInNativeResolution(2)
            parent: root
            anchors.top: settingsList.top
            anchors.topMargin: 16
            anchors.left: settingsList.right
            anchors.leftMargin: 16
            anchors.bottom: settingsList.bottom
            anchors.bottomMargin: 16
            padding: 0
            policy: (settingsList.height < settingsList.contentHeight) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            contentItem: Rectangle {
                color: "#646464"
            }
            background: null
        }
    }
}
