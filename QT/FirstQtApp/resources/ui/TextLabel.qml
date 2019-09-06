import QtQuick 2.11

Item {
    id: root
    property string text
    property color color
    property real fontPixelSize
    property real fontCapitalHeight: fontPixelSize / constants.fontCapitalHeightScaling
    property real lineSpacing: 0.5 * fontCapitalHeight
    property int maximumLineCount: 1
    property int horizontalAlignment: Text.AlignLeft
    property bool doElide: false
    readonly property real contentWidth: textContent.contentWidth
    readonly property real contentHeight: ( textContent.lineCount - 1 ) * textContent.lineHeight + fontCapitalHeight + 0.5
    readonly property int lineCount: textContent.lineCount

    implicitWidth: contentWidth
    implicitHeight: contentHeight

    onWidthChanged: {
        if (width != contentWidth) {
            textContent.width = root.width
        }
    }

    baselineOffset: textContent.baselineOffset + textContent.y

    FontMetrics
    {
        id: fontMetrics
        font.pixelSize: fontPixelSize
    }

    Text {
        id: textContent
        // Workaround for qt/windows bug QTBUG-56052 (extra empty space above ascent)
        y: fontCapitalHeight - fontMetrics.ascent - 0.5
        text: parent.text
        color: parent.color
        font.pixelSize: fontMetrics.font.pixelSize
        lineHeightMode: Text.FixedHeight
        lineHeight: fontCapitalHeight + lineSpacing
        maximumLineCount: parent.maximumLineCount
        horizontalAlignment: parent.horizontalAlignment
        wrapMode: Text.WordWrap
        elide: doElide ? Text.ElideRight : Text.ElideNone
        textFormat: Text.PlainText
    }
}
