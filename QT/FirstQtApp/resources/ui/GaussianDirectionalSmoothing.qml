import QtQuick 2.11

ShaderEffect {
    id: shaderItem
    property Item source
    property real sigma
    property real horizontalStep: 0.0
    property real verticalStep: 0.0
    property point shift: Qt.point(horizontalStep, verticalStep);

    onSigmaChanged: updateFragmentShader()

    function kernelFunction(x){
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

        newFragmentShader = "#version 130
        in vec2 qt_TexCoord0;
        uniform float qt_Opacity;
        uniform sampler2D source;
        uniform vec2 shift;
        out vec4 fragColor;

        void main() {
            fragColor = vec4(0.0f, 0.0f, 0.0f, 0.0f);
        "

        i = -kernelRadius + 1
        while (i < kernelRadius) {
            if (i === 0) {
                newFragmentShader += "fragColor += texture(source, qt_TexCoord0) * " + filterValues[0] + "f;\n"
                ++i
            } else {
                weight1 = filterValues[Math.abs(i)]
                weight2 = filterValues[Math.abs(i + 1)]
                weightSum = weight1 + weight2
                newFragmentShader += "fragColor += texture(source, qt_TexCoord0 + " + (i + weight2 / weightSum) + "f * shift) * " + weightSum + ";\n"
                i += 2
            }
        }

        newFragmentShader += "
            fragColor *= qt_Opacity;
        }"

        fragmentShader = newFragmentShader
    }
}
