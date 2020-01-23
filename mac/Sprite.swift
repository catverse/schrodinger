import GameplayKit

final class Sprite: GKComponent {
    var position = vector_int2.zero {
        didSet {
            node.run(.move(to: (node.scene as! Scene).point(position), duration: 0.2), withKey: "move")
        }
    }
    let node = SKSpriteNode(texture: nil, size: .init(width: 32, height: 32))
}
