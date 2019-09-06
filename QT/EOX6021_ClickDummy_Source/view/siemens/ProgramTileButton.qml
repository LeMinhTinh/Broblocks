import QtQuick 2.12
import bsh.backend 1.0

ImageTileButton {
    property EOX6021ProgramDefinition programDefinition

    title: programDefinition ? programDefinition.tileText : ""
    imageSource: programDefinition ? programDefinition.tileImage : ""
    iconSource: programDefinition ? programDefinition.tileIcon : ""
    width: constants.programTileWidth
    height: constants.programTileHeight
    iconCenterOffsetToTop: 70
    textBackgroundOpacity: 0
    textSideMargin: 6
    textSize: constants.descriptionTextSize
    textAreaHeight: 152
    centerInTextArea: true
    textColor: themedLightContrastColor
    hasShine: true
    hasShadow: true
}
