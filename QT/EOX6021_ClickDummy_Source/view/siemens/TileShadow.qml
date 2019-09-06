import QtQuick 2.12

Item {
    anchors.fill: parent
    FastImage {
        source: "file:resources/siemens/images/shadow_l.png"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.left
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_lb.png"
        anchors.top: parent.bottom
        anchors.right: parent.left
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_b.png"
        anchors.top: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_rb.png"
        anchors.top: parent.bottom
        anchors.left: parent.right
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_r.png"
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.right
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_ru.png"
        anchors.left: parent.right
        anchors.bottom: parent.top
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_u.png"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.top
    }
    FastImage {
        source: "file:resources/siemens/images/shadow_lu.png"
        anchors.right: parent.left
        anchors.bottom: parent.top
    }
}
