import SpriteKit

final class Home: SKScene {
    private weak var player: SKSpriteNode!
    private var key = Key.none
    private var time = TimeInterval(0)
    private let playerSpeed = CGFloat(100)
    
    override func sceneDidLoad() {
        player = childNode(withName: "Player") as? SKSpriteNode
    }
    
    override func update(_ time: TimeInterval) {
        if time - self.time > 0.05 {
            switch key {
            case .up: player.physicsBody!.velocity = .init(dx: 0, dy: playerSpeed)
            case .down: player.physicsBody!.velocity = .init(dx: 0, dy: -playerSpeed)
            case .left: player.physicsBody!.velocity = .init(dx: -playerSpeed, dy: 0)
            case .right: player.physicsBody!.velocity = .init(dx: playerSpeed, dy: 0)
            default: player.physicsBody!.isResting = true
            }
            key = .none
            self.time = time
        }
    }
    
    override func keyDown(with: NSEvent) {
        key = Key(rawValue: with.keyCode) ?? .none
    }
}
