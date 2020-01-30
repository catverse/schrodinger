import SpriteKit

final class DarknessNode: SKEffectNode {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        filter = Filter()
        shouldEnableEffects = true
    }
}

private final class Filter: CIFilter {
    @objc dynamic var inputImage: CIImage?
    private let saturation = CIFilter(name: "CIColorControls", parameters: ["inputSaturation" : 0, "inputBrightness" : -0.3, "inputContrast" : 1.5])!
    private let color = CIFilter(name: "CIColorMonochrome", parameters: ["inputColor" : CIColor(cgColor: .shade()), "inputIntensity" : 0.75])!

    override var outputImage: CIImage? {
        saturation.setValue(inputImage, forKey: "inputImage")
        color.setValue(saturation.outputImage, forKey: "inputImage")
        return color.outputImage
    }
}
