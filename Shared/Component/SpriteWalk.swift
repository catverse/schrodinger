import GameplayKit

final class SpriteWalk: GKComponent {
    let node = SKSpriteNode(texture: nil, size: .init(width: SpriteWalk.size, height: SpriteWalk.size))
    private static let size = CGFloat(32)
    
    func animate(_ vector: vector_int2) {
        node.run(.move(to: point(vector), duration: 0.2), withKey: "move")
    }
    
    func move(_ vector: vector_int2) {
        node.position = point(vector)
    }
    
    private func point(_ vector: vector_int2) -> CGPoint {
        .init(x: .init(vector.x) * SpriteWalk.size, y: .init(vector.y) * SpriteWalk.size)
    }
}
