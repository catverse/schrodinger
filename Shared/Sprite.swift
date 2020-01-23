import GameplayKit

final class Sprite: GKComponent {
    private static let size = CGFloat(32)
    
    var position = vector_int2.zero {
        didSet {
            node.run(.move(to: .init(x: .init(position.x) * Sprite.size, y: .init(position.y) * Sprite.size), duration: 0.2), withKey: "move")
        }
    }
    
    let node = SKSpriteNode(texture: nil, size: .init(width: Sprite.size, height: Sprite.size))
}
