import QtQuick 2.12
import QtQuick.Layouts 1.12

ConfigString {
    id: root
    property int timeout: 3000

    iconColor: constants.defaultBlue
    valueColor: "#000000"
    textSize: constants.textSizeF12

    Timer {
        interval: timeout
        repeat: false
        running: true
        onTriggered: {
            root.destroy()
        }
    }
}
