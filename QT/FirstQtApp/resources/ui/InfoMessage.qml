import QtQuick 2.11
import QtQuick.Layouts 1.11

//消息窗口(snackbar)

ConfigString {
    id: root
    property int timeout: 3000

    iconColor: constants.defaultBlue
    valueColor: "#000000"
    textSize: 25

    Timer {
        interval: timeout
        repeat: false
        running: true
        onTriggered: {
            root.destroy()
        }
    }
}
