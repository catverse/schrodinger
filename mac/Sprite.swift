import GameplayKit

final class Sprite: GKComponent {
    let node = SKSpriteNode()
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        node.size = .init(width: 100, height: 100)
    }
}
