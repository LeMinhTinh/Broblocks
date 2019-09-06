import QtQuick 2.11
import bsh.eox6021 1.0

ImageTileButton {
    id: root

    property EOX6021ProgramDefinition programDefinition

    property real offset: 5 * mm
    signal favorite()
    signal start()

    textSize: constants.descriptionTextSize
    textAreaHeight: 168
    imageSource: programDefinition ? programDefinition.favoriteTileImage : ""
    title: programDefinition ? programDefinition.name : ""
    textColor: (programDefinition && programDefinition.useDarkTheme) ? constants.lightFavoriteTileTextColor : "#202020"
    property color configColor: textColor
    property bool isStartEnabled: true
    property color startTextColor: isStartEnabled ? themedStrongContrastColor : "#33ffffff"
    colorizationIntensity: 0.12
    property bool hasDragIndicator: false

    IconButton {
       id: favoriteStar
       anchors.top: parent.top
       anchors.topMargin: 15
       anchors.right: parent.right
       anchors.rightMargin: 15
       source: "file:resources/icons/2_icn_favorit_active.png"
       color: constants.defaultBlue
       onClicked: {
           favorite()
       }
    }

    ConfigString {
       id: temperatureString
       anchors.verticalCenter: configStartSeperator.verticalCenter
       anchors.horizontalCenter: parent.left
       anchors.horizontalCenterOffset: parent.width * 0.25
       height: configStartSeperator.height + 40
       value: programDefinition ? programDefinition.temperature.value() : 0
       Connections {
           target: programDefinition ? programDefinition.temperature : null
           onIntervalIndexChanged: temperatureString.value = programDefinition.temperature.value()
       }
       valueColor: configColor
       unit: "°C"
       textSize: root.textSize
       visible: !durationString.visible
    }

    function getHoursOfDuration(durationInMinutes) {
        var h = Math.floor(durationInMinutes / 60)
        if (h < 10) {
            return "0" + h
        }
        else {
            return h.toString()
        }
    }

    function getMinutesOfDuration(durationInMinutes) {
        var m = durationInMinutes % 60
        if (m < 10) {
            return "0" + m
        }
        else {
            return m.toString()
        }
    }

    ConfigString {
        id: durationString
        property int hours: programDefinition && programDefinition.duration ? getHoursOfDuration(programDefinition.duration.value()) : 0
        property int minutes: programDefinition && programDefinition.duration ? getMinutesOfDuration(programDefinition.duration.value()) : 0
        Connections {
            target: programDefinition && programDefinition.duration ? programDefinition.duration : null
            onIntervalIndexChanged: {
                durationString.hours = getHoursOfDuration(programDefinition.duration.value())
                durationString.minutes = getMinutesOfDuration(programDefinition.duration.value())
            }
        }
        anchors.verticalCenter: configStartSeperator.verticalCenter
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: parent.width * 0.25
        height: configStartSeperator.height + 40
        value:  programDefinition && programDefinition.duration && programDefinition.duration.isEnabled ? hours : "--"
        unit: "h"
        valueSecondary: programDefinition && programDefinition.duration && programDefinition.duration.isEnabled ? minutes : "--"
        unitSecondary: "m"
        seperatorString: " "
        unitOnTop: false
        valueColor: configColor
        textSize: root.textSize
        visible: programDefinition && programDefinition.duration && programDefinition.duration.isEnabled
    }

    Image {
       id: configStartSeperator
       anchors.bottom: parent.bottom
       anchors.bottomMargin: 20
       anchors.horizontalCenter: parent.horizontalCenter
       source: "file:resources/icons/separator_fav.png"
       width: 2.5
    }

    FooterButton {
       anchors.verticalCenter: configStartSeperator.verticalCenter
       anchors.left: configStartSeperator.horizontalCenter
       width: 0.5 * parent.width
       height: configStartSeperator.height + 40
       text: "Start"
       color: "#00000000"
       fontColor: root.startTextColor
       enabled: root.isStartEnabled
       onClicked: {
            start()
       }
    }

    Item {
        id: dragIndicator
        scale: 1.2
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0.5 * (tile.height - textAreaHeight) - 0.5 * height
        visible: hasDragIndicator
        width: 1.5 * dragIndicatorImage.width
        height: 2 * dragIndicatorImage.height
        Rectangle {
            radius: 0.5 * height
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.6
        }
        Image {
            id: dragIndicatorImage
            source:"file:resources/icons/icn_draganddrop.png"
            anchors.centerIn: parent
        }
    }
}
