import QtQuick 2.12

Item {
    id: root
    property string text
    property color color
    property real fontPixelSize
    property string fontFamily: display.font.family
    property real fontLetterSpacing: constants.fontLetterSpacing
    property real lineSpacing: 0.5 * fontPixelSize
    property int maximumLineCount: 1
    property int horizontalAlignment: Text.AlignLeft
    property bool doElide: false

    readonly property real fontCapitalHeight: Math.round(root.fontPixelSize / constants.fontCapitalHeightScaling)
    readonly property real contentWidth: text ? textContent.contentWidth : 0
    readonly property real contentHeight: Math.max(0, ( textContent.lineCount - 1 )) * textContent.lineHeight + fontCapitalHeight
    readonly property int lineCount: textContent.lineCount

    implicitWidth: contentWidth
    implicitHeight: contentHeight
    baselineOffset: textContent.baselineOffset + textContent.y

    FontMetrics
    {
        id: fontMetrics
        font.pixelSize: root.fontPixelSize
        font.family: root.fontFamily
        font.letterSpacing: root.fontLetterSpacing
    }

    Text {
        id: textContent
        width: parent.width
        // Workaround for qt/windows bug QTBUG-56052 (extra empty space above ascent)
        y: root.fontCapitalHeight - fontMetrics.ascent
        text: root.text
        color: root.color
        font.pixelSize: fontMetrics.font.pixelSize
        font.family: root.fontFamily
        font.letterSpacing: root.fontLetterSpacing
        lineHeightMode: Text.FixedHeight
        lineHeight: root.fontCapitalHeight + root.lineSpacing
        maximumLineCount: root.maximumLineCount
        horizontalAlignment: root.horizontalAlignment
        wrapMode: (root.maximumLineCount === 1) ? Text.NoWrap : Text.WordWrap
        elide: doElide ? Text.ElideRight : Text.ElideNone
        textFormat: Text.PlainText
    }
}
