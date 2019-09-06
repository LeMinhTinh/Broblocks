ConfigTile {
    id:root

    property bool isEnabled: false

    overview: ConfigOverview {
        id: configOverviewTile
        anchors.fill: parent

        optionName: root.optionName
        iconSource: root.optionIcon
        isEnabled: root.isEnabled
    }
}
