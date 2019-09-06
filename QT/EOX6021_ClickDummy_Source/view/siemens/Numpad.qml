import QtQuick 2.12

Item {
    property real spacing: 12

    signal number(int number)
    signal backspace()

    width: childrenRect.width
    height: childrenRect.height

    KeyTile {
        id: key_one
        text: "1"
        onPressed: number(1)
    }

    KeyTile {
        id: key_two
        text: "2"
        anchors.left: key_one.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_one.verticalCenter
        onPressed: number(2)
    }

    KeyTile {
        id: key_three
        text: "3"
        anchors.left: key_two.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_one.verticalCenter
        onPressed: number(3)
    }

    KeyTile {
        id: key_four
        text: "4"
        anchors.top: key_one.bottom
        anchors.topMargin: spacing
        onPressed: number(4)
    }

    KeyTile {
        id: key_five
        text: "5"
        anchors.left: key_four.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_four.verticalCenter
        onPressed: number(5)
    }

    KeyTile {
        id: key_six
        text: "6"
        anchors.left: key_five.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_four.verticalCenter
        onPressed: number(6)
    }

    KeyTile {
        id: key_seven
        text: "7"
        anchors.top: key_four.bottom
        anchors.topMargin: spacing
        onPressed: number(7)
    }

    KeyTile {
        id: key_eight
        text: "8"
        anchors.left: key_seven.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_seven.verticalCenter
        onPressed: number(8)
    }

    KeyTile {
        id: key_nine
        text: "9"
        anchors.left: key_eight.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_seven.verticalCenter
        onPressed: number(9)
    }

    KeyTile {
        id: key_zero
        text: "0"
        anchors.top: key_seven.bottom
        anchors.topMargin: spacing
        width: 101 * 2 + spacing
        onPressed: number(0)
    }

    KeyTile {
        id: key_backspace
        iconSource: "file:resources/siemens/icons/icn_backspace.png"
        anchors.left: key_zero.right
        anchors.leftMargin: spacing
        anchors.verticalCenter: key_zero.verticalCenter
        onPressed: backspace()
    }
}
