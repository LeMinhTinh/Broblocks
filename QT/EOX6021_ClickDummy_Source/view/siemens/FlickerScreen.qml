import QtQuick 2.12
import QtQuick.Controls 2.12

BaseScreen {
    id: root
    property Item titleContent: Item {}
    property Item flickContent
    property real scrollBarHeight: approximateInNativeResolution(2)
    property Item flickableItem: flickable
    property bool isFlickableClipped: false
    property real sideMargin: 24

    onTitleContentChanged: titleContent.parent = titleContainer
    onFlickContentChanged: flickContent.parent = flickable.contentItem

    content: Item{
        Item {
            id: titleContainer
            anchors.left: parent.left
            anchors.leftMargin: root.sideMargin
            anchors.bottom: flickable.top
            anchors.bottomMargin: root.sideMargin
            width: titleContent.width
            height: titleContent.height
        }

        Flickable {
            id: flickable
            anchors.left: parent.left
            anchors.leftMargin: root.sideMargin
            anchors.right: parent.right
            anchors.rightMargin: root.sideMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: root.sideMargin
            height: contentHeight
            contentWidth: flickContent.width
            contentHeight: flickContent.height
            clip: root.isFlickableClipped
            flickableDirection : Flickable.HorizontalFlick

            ScrollBar.horizontal: ScrollBar {
                parent: flickable.parent
                anchors.top: flickable.bottom
                anchors.topMargin: 0.5 * (root.sideMargin - root.scrollBarHeight)
                anchors.left: flickable.left
                anchors.right: flickable.right
                height: root.scrollBarHeight
                padding: 0
                policy: (flickable.width < flickable.contentWidth) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
                contentItem: Rectangle {
                    color: constants.scrollBarColor
                }
                background: null
            }
        }
    }
}
