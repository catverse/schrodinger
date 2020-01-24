import GameplayKit

final class Sprite: GKComponent {
    private static let size = CGFloat(32)
    private(set) var position = vector_int2.zero
    
    private var point: CGPoint {
        .init(x: .init(position.x) * Sprite.size, y: .init(position.y) * Sprite.size)
    }
    
    let node = SKSpriteNode(texture: nil, size: .init(width: Sprite.size, height: Sprite.size))
    
    func animate(_ position: vector_int2) {
        self.position = position
        node.run(.move(to: point, duration: 0.2), withKey: "move")
    }
    
    func move(_ position: vector_int2) {
        self.position = position
        node.position = point
    }
}
