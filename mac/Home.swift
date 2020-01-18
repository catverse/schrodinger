import SpriteKit

final class Home: SKScene {
    private weak var player: SKSpriteNode!
    private var move = CGPoint.zero
    private var keys = CGPoint.zero
    private let playerSpeed = CGFloat(100)
    
    override func sceneDidLoad() {
        player = childNode(withName: "Player") as? SKSpriteNode
    }
    
    override func update(_ currentTime: TimeInterval) {
        if keys.x > 0 {
            move.x += 200
            keys.x -= 1
        } else if keys.x < 0 {
            move.x -= 200
            keys.x += 1
        }
        if keys.y > 0 {
            move.y += 200
            keys.y -= 1
        } else if keys.y < 0 {
            move.y -= 200
            keys.y += 1
        }
    }
    
    override func keyDown(with: NSEvent) {
        switch with.keyCode {
        case 126: keys.y += 1
        case 125: keys.y -= 1
        case 123: keys.x -= 1
        case 124: keys.x += 1
        default: break
        }
    }
    
    override func didSimulatePhysics() {
        if move != .zero {
            player.physicsBody!.velocity = .init(dx: move.x * speed, dy: move.y * speed)
            if move.x > 0 {
                move.x -= 100
            } else if move.x < 0 {
                move.x += 100
            }
            if move.y > 0 {
                move.y -= 100
            } else if move.y < 0 {
                move.y += 100
            }
        } else {
            player.physicsBody!.isResting = true
        }
    }
}
