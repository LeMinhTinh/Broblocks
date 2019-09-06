import QtQuick 2.11
import bsh.eox6021 1.0

ConfigTileTwoWheels {
    property int remainingTime: backend.currentProgram.remainingTime

    primaryOptionUnit: "h"
    secondaryOptionUnit: "m"
    seperator: " "
    isCircular: true
    optionName: "Duration"
    optionIcon: "file:resources/icons/duration.png"
    onReset: {
        //TODO Quick Hack to force update from already reset state
        primaryOptionIndex = 1
        secondaryOptionIndex = 1
        primaryOptionIndex = 0
        secondaryOptionIndex = 0
    }
    primaryPercentageOfSeperator: 0.03
    secondaryPercentageOfSeperator: 0.06

    function createHourOptions() {
        var stringList = []
        for (var i = 0; i < 24; ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function createMinuteOptions() {
        var stringList = []
        for (var i = 0; i < 60; ++i) {
            stringList.push(i.toString())
        }
        return stringList
    }

    function setProgram() {
        var remainingTime = currentPrimaryIndex * 3600 + currentSecondaryIndex * 60
        backend.currentProgram.remainingTime = remainingTime <= 0 ? -1 : remainingTime
    }

    primaryOption: createHourOptions()
    primaryOptionIndex: remainingTime > 0 ? Math.floor(remainingTime / 3600) : 0
    primaryNumOfSideBars: 3
    primaryPeriodOfWheelLabel: 1

    secondaryOption: createMinuteOptions()
    secondaryOptionIndex: remainingTime > 0 ? Math.floor(remainingTime / 60) % 60 : 0
    secondaryNumOfSideBars: 7
    secondaryPeriodOfWheelLabel: 5

    optionEnabled: true

    currentEnabled: currentPrimaryIndex != 0 || currentSecondaryIndex != 0
}
