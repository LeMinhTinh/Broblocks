import QtQuick 2.11

//各个stackview页面共享的header
Item {
    property string title: ""
    property bool hasBackButton: false
    property var backHandler: function() { display.pop() }
    property bool hasEditButton: false
    property var editHandler: function() {}
    property color editColor: themedStrongContrastColor
    property bool hasSaveButton: false
    property var saveHandler: function() {}
    property color saveColor: themedStrongContrastColor
    property real defaultMargin: 20
    property bool runAnimation: true

    property Animation enterAnimation: SequentialAnimation {
        running: runAnimation
        PropertyAction {
            target: backButton
            property: "opacity"
            value: 0
        }
        PauseAnimation {
            duration: 50
        }
        ParallelAnimation {
            NumberAnimation {
                target: backButton
                property: "x"
                from: 311
                to: 11
                duration: 400
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                targets: [backButton, titleLabel, editButton, saveButton]
                property: "opacity"
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.InCubic
            }
        }
    }

    height: 96




    IconButton {
        id: backButton
        anchors{
            left: parent.left
            leftMargin: 20
            verticalCenter: row.verticalCenter
        }

        width: height*1.2
        height: parent.height*0.6
        visible: hasBackButton
        source: "file:resources/icons/back.png"
        color: themedStrongContrastColor
        onClicked: backHandler()
    }

    Row{
        id:row
        //anchors.left: parent.left
        //anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.rightMargin: 20
        width: parent.width
        layoutDirection: Qt.RightToLeft
        spacing: 20



/*        TextLabel {
            id: titleLabel0
            anchors.verticalCenter: parent.verticalCenter
            //        anchors.left: hasBackButton ? backButton.right : parent.left
            anchors.leftMargin: 32//editButton.visible ? editButton.width + 2 * defaultMargin : defaultMargin
            //        anchors.right: wlanIcon.left
            anchors.rightMargin: editButton.visible ? editButton.width + 2 * defaultMargin : defaultMargin
            fontPixelSize: constants.descriptionTextSize
            color: themedLightContrastColor
            text: title
            horizontalAlignment: Text.AlignHCenter
        }
*/
        IconButton {
            id: editButton
            visible: hasEditButton
            anchors.verticalCenter: parent.verticalCenter
            x: titleLabel.x + 0.5 * titleLabel.width + 0.5 * titleLabel.contentWidth + defaultMargin
            source: "file:resources/icons/edit.png"
            color: editColor
            onClicked: editHandler()
            iconWidth: 31
            iconHeight: 31
            width: iconWidth + 2 * defaultMargin
            height: iconHeight + 2 * defaultMargin
        }
        MouseArea {
            id: saveButton
            visible: hasSaveButton
            anchors.bottom: titleLabel.bottom
            //        anchors.left: editButton.right
            anchors.leftMargin: 0.5 * defaultMargin
            width: saveLabel.width
            height: saveLabel.height
            onClicked: saveHandler()
            TextLabel {
                id: saveLabel
                text: "Save"
                color: saveColor
                fontPixelSize: titleLabel.fontPixelSize * 0.75
            }
        }

        Icon {
            id: wlanIcon
            source: "file:resources/icons/wlan.png"
                    x: parent.width  - width -20
            anchors.verticalCenter: parent.verticalCenter
            color: themedLightContrastColor
        }

        TextLabel {
            id: clockLabel
                    anchors.left: settingsButton.right
            anchors.verticalCenter: parent.verticalCenter
            //        text: getHhMmFromSeconds(backend.wallClock)
            text:clickDummy.date.getHours()+':'+date.getMinutes()+' '+['Sun','Mon','Tue','Wed','Thu','Fri','Sat'][date.getDay()]
            fontPixelSize: constants.descriptionTextSize
            color: themedLightContrastColor
            //        horizontalAlignment: Text.AlignRight
        }

        IconButton {
            id: settingsButton
            source: "file:resources/icons/setting.png"
             x: parent.width - 30 * mm - width
            color: themedStrongContrastColor
            anchors.verticalCenter: parent.verticalCenter
//            onClicked: display.push("SettingScreen.qml")

        }

        TextLabel {
            id: titleLabel
            anchors.verticalCenter: parent.verticalCenter
            //        anchors.left: hasBackButton ? backButton.right : parent.left
            //anchors.leftMargin: 20//editButton.visible ? editButton.width + 2 * defaultMargin : defaultMargin
            //        anchors.right: wlanIcon.left
            //anchors.horizontalCenter: row.horizontalCenter
            anchors.centerIn: parent

            anchors.rightMargin: 500//editButton.visible ? editButton.width + 2 * defaultMargin : defaultMargin
            fontPixelSize: constants.descriptionTextSize
            color: themedLightContrastColor
            text: title
            //horizontalAlignment: Text.AlignLeft//Text.AlignHCenter
        }

    }

}
