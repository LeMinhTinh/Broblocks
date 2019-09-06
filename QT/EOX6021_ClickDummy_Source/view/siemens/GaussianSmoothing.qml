import QtQuick 2.12

Item {
    id: root
    property Item source
    property real sigma

    GaussianDirectionalSmoothing {
        id: horizontalSmooth
        anchors.fill: parent
        horizontalStep: 1.0 / source.width
        source: parent.source
        sigma: root.sigma
        visible: false
    }

    ShaderEffectSource {
        id: buffer
        anchors.fill: horizontalSmooth
        sourceItem: horizontalSmooth
        visible: false
    }

    GaussianDirectionalSmoothing {
        id: verticalSmooth
        anchors.fill: parent
        verticalStep: 1.0 / source.height
        source: buffer
        sigma: root.sigma
    }
}
