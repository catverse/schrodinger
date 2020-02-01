import SpriteKit

final class InventoryScene: SKScene {
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
    }
}
