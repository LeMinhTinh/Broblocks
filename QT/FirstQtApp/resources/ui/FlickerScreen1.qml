import QtQuick 2.11
import QtQuick.Controls 2.4

BaseScreen {
    id: root
    property Item titleContent: Item {}
    onTitleContentChanged: titleContent.parent = titleContainer
    property Item flickContent
    onFlickContentChanged: flickContent.parent = flickable.contentItem
    property real scrollBarHeight: 4
    flickableItem: flickable
    property bool isFlickableClipped: false
    property bool centerFlickable: false

    content: Item{
        Item {
            id: titleContainer
            anchors.left: parent.left
            anchors.leftMargin: 32
            anchors.bottom: flickable.top
            anchors.bottomMargin: 24
            width: titleContent.width
            height: titleContent.height
        }

        Flickable {
            id: flickable
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 48
            anchors.bottom: centerFlickable ? undefined : parent.bottom
            anchors.bottomMargin: 12 - 0.5 * scrollBarHeight
            anchors.verticalCenter: centerFlickable ? parent.verticalCenter : undefined
            height: contentHeight + 12 + 0.5 * scrollBarHeight
            contentWidth: flickContent.width
            contentHeight: flickContent.height
            clip: isFlickableClipped
            flickableDirection : Flickable.HorizontalFlick

            ScrollBar.horizontal: ScrollBar {
                height: scrollBarHeight
                policy: (flickable.width < flickable.contentWidth) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                contentItem: Rectangle {
                    color: constants.scrollBarColor
                }
                background: Rectangle {
                    color: "#00000000"
                }
            }
        }
    }
}
