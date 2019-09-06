import QtQuick 2.0
import bsh.eox6021 1.0

//二级菜单的方块按钮

ImageTileButton {
    property EOX6021ProgramDefinition programDefinition

    title: programDefinition ? programDefinition.name : ""
    imageSource: programDefinition ? programDefinition.tileImage : ""
    iconSource: programDefinition ? programDefinition.tileIcon : ""
    width: 354
    height: 408
    iconOffset: 10
    textSideMargin: 6
    textSize: constants.descriptionTextSize
    textAreaHeight: 110
    textColor: themedLightContrastColor

    TileShine {}
}
