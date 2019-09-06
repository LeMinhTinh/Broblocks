import QtQuick 2.12

ShaderEffect {
    id: shaderItem
    property Item source
    property real sigma
    property real horizontalStep: 0.0
    property real verticalStep: 0.0
    property point shift: Qt.point(horizontalStep, verticalStep);

    onSigmaChanged: updateFragmentShader()

    function kernelFunction(x) {
        var xBySigma = x / shaderItem.sigma
        return Math.pow(Math.E, -0.5 * xBySigma * xBySigma) / (Math.sqrt(2 * Math.PI) * shaderItem.sigma);
    }

    function updateFragmentShader() {
        var kernelRadius = 2 * Math.ceil(sigma) + 1, // >95% accuracy
            normalizer, weight1, weight2, weightSum,
            filterValues = new Array(kernelRadius),
            i, newFragmentShader;

        weightSum = 0.0
        for (i = 0; i < kernelRadius; ++i) {
            filterValues[i] = kernelFunction(i)
            weightSum += filterValues[i]
        }
        normalizer = 1.0 / (2.0 * weightSum - filterValues[0])
        for (i = 0; i < kernelRadius; ++i) {
            filterValues[i] *= normalizer
        }

        newFragmentShader = "#version 100
        varying highp vec2 qt_TexCoord0;
        uniform sampler2D source;
        uniform lowp float qt_Opacity;
        uniform highp vec2 shift;

        void main() {
        "

        i = -kernelRadius + 1
        while (i < kernelRadius) {
            newFragmentShader += "gl_FragColor " + ((i === -kernelRadius + 1) ? "= " : "+= ")
            if (i === 0) {
                newFragmentShader += "texture2D(source, qt_TexCoord0) * " + filterValues[0] + ";\n"
                ++i
            } else {
                weight1 = filterValues[Math.abs(i)]
                weight2 = filterValues[Math.abs(i + 1)]
                weightSum = weight1 + weight2
                newFragmentShader += "texture2D(source, qt_TexCoord0 + " + (i + weight2 / weightSum) + " * shift) * " + weightSum + ";\n"
                i += 2
            }
        }

        newFragmentShader += "
            gl_FragColor *= qt_Opacity;
        }"

        fragmentShader = newFragmentShader
    }

    vertexShader: "#version 100
        uniform highp mat4 qt_Matrix;
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        varying highp vec2 qt_TexCoord0;
        void main() {
            qt_TexCoord0 = qt_MultiTexCoord0;
            gl_Position = qt_Matrix * qt_Vertex;
        }"
}
