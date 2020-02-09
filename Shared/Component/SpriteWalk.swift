import GameplayKit

final class SpriteWalk: GKComponent {
    private static let size = CGFloat(32)
    
    private var point: CGPoint {
        .init(x: .init(memory.game.location.position.x) * SpriteWalk.size, y: .init(memory.game.location.position.y) * SpriteWalk.size)
    }
    
    let node = SKSpriteNode(texture: nil, size: .init(width: SpriteWalk.size, height: SpriteWalk.size))
    
    func animate(_ position: vector_int2) {
        memory.game.location.position = position
        node.run(.move(to: point, duration: 0.2), withKey: "move")
    }
    
    func move(_ position: vector_int2) {
        memory.game.location.position = position
        node.position = point
    }
}
