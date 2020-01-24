import GameplayKit

final class WalkSprite: GKComponent {
    private static let size = CGFloat(32)
    private(set) var position = vector_int2.zero
    
    private var point: CGPoint {
        .init(x: .init(position.x) * WalkSprite.size, y: .init(position.y) * WalkSprite.size)
    }
    
    let node = SKSpriteNode(texture: nil, size: .init(width: WalkSprite.size, height: WalkSprite.size))
    
    func animate(_ position: vector_int2) {
        self.position = position
        node.run(.move(to: point, duration: 0.2), withKey: "move")
    }
    
    func move(_ position: vector_int2) {
        self.position = position
        node.position = point
    }
}
