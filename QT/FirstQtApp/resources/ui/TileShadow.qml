import QtQuick 2.11

Item {
    anchors.fill: parent
    Image {
        source: "file:resources/images/shadow_l.png"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.left
    }
    Image {
        source: "file:resources/images/shadow_lb.png"
        anchors.top: parent.bottom
        anchors.right: parent.left
    }
    Image {
        source: "file:resources/images/shadow_b.png"
        anchors.top: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
    Image {
        source: "file:resources/images/shadow_rb.png"
        anchors.top: parent.bottom
        anchors.left: parent.right
    }
    Image {
        source: "file:resources/images/shadow_r.png"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.right
    }
    Image {
        source: "file:resources/images/shadow_ru.png"
        anchors.left: parent.right
        anchors.bottom: parent.top
    }
    Image {
        source: "file:resources/images/shadow_u.png"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.top
    }
    Image {
        source: "file:resources/images/shadow_lu.png"
        anchors.right: parent.left
        anchors.bottom: parent.top
    }
}
