import QtQuick 2.12
import bsh.backend 1.0

ImageTileButton {
    id: root

    property EOX6021ProgramDefinition programDefinition

    signal favorite()
    signal start()

    textSize: constants.textSizeF1
    textAreaHeight: 168
    maximumTextLines: 2
    imageSource: programDefinition ? programDefinition.favoriteTileImage : ""
    title: programDefinition ? programDefinition.name : ""
    textColor: (programDefinition && programDefinition.useDarkTheme) ? constants.lightFavoriteTileTextColor : "#202020"
    property color configColor: textColor
    property bool isStartEnabled: true
    property color startTextColor: isStartEnabled ? themedStrongContrastColor : "#33ffffff"
    textBackgroundOpacity: 0.08
    property bool hasHorizontalDragIndicator: false
    property bool hasVerticalDragIndicator: false

    IconButton {
       id: favoriteStar
       anchors.top: parent.top
       anchors.right: parent.right
       width: iconWidth + 24
       height: iconHeight + 24
       source: "file:resources/siemens/icons/favourite_filled.png"
       color: constants.defaultBlue
       onClicked: {
           favorite()
       }
    }

    ConfigString {
       id: temperatureString
       anchors.verticalCenter: configStartseparator.verticalCenter
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.horizontalCenterOffset:  0.5 * (configStartseparator.x - parent.width)
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

    ConfigString {
        id: durationString
        property string hours: programDefinition && programDefinition.duration ? timeString(getHours(programDefinition.duration.value())) : 0
        property string minutes: programDefinition && programDefinition.duration ? timeString(getMinutes(programDefinition.duration.value())) : 0
        Connections {
            target: programDefinition && programDefinition.duration ? programDefinition.duration : null
            onIntervalIndexChanged: {
                durationString.hours = timeString(getHours(programDefinition.duration.value()))
                durationString.minutes = timeString(getMinutes(programDefinition.duration.value()))
            }
        }
        anchors.verticalCenter: configStartseparator.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset:  0.5 * (configStartseparator.x - parent.width)
        value: programDefinition && programDefinition.duration && programDefinition.duration.isEnabled ? hours : "--"
        unit: "h"
        valueSecondary: programDefinition && programDefinition.duration && programDefinition.duration.isEnabled ? minutes : "--"
        unitSecondary: "min"
        separatorString: " "
        unitOnTop: false
        valueColor: configColor
        textSize: root.textSize
        visible: programDefinition && programDefinition.duration && programDefinition.duration.isEnabled
    }

    Image {
       id: configStartseparator
       anchors.verticalCenter: parent.bottom
       anchors.verticalCenterOffset: -36
       anchors.horizontalCenter: parent.right
       anchors.horizontalCenterOffset: -130
       source: "file:resources/siemens/icons/separator.png"
       width: approximateInNativeResolution(2, 2)
    }

    FooterButton {
       anchors.verticalCenter: configStartseparator.verticalCenter
       anchors.left: configStartseparator.right
       anchors.right: parent.right
       width: 0.5 * parent.width
       height: configStartseparator.height + 20
       text: "Start"
       color: "#00000000"
       fontColor: root.startTextColor
       enabled: root.isStartEnabled
       onClicked: {
            start()
       }
    }

    Item {
        id: dragIndicatorHorizontal
        scale: 1.2
        anchors.horizontalCenter: parent.horizontalCenter
        y: 0.5 * (tile.height - textAreaHeight) - 0.5 * height
        visible: hasHorizontalDragIndicator || hasVerticalDragIndicator
        width: hasHorizontalDragIndicator ? 90 : 42
        height: hasVerticalDragIndicator ? 90 : 42
        Rectangle {
            radius: 0.5 * Math.min(width, height)
            anchors.fill: parent
            color: "#ffffff"
            opacity: 0.6
        }
        Image {
            source:"file:resources/siemens/icons/icn_draganddrop.png"
            anchors.centerIn: parent
            visible: hasHorizontalDragIndicator
        }
        Image {
            source:"file:resources/siemens/icons/icn_draganddrop.png"
            anchors.centerIn: parent
            visible: hasVerticalDragIndicator
            rotation: 90
        }
    }
}
