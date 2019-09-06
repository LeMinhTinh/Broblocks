import QtQuick 2.11

Item {
    property Item source
    property real radius

    GaussianDirectionalSmoothing {
        id: horizontalSmooth
        anchors.fill: parent
        horizontalStep: 1.0 / source.width
        source: parent.source
        sigma: Math.max(0.001, 0.5 * parent.radius)
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
        anchors.fill: buffer
        verticalStep: 1.0 / source.height
        source: buffer
        sigma: horizontalSmooth.sigma
    }
}
