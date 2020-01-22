import SpriteKit
import GameplayKit

final class Game: SKView, SKSceneDelegate {
    let player = Player()
    private var time = TimeInterval()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsPhysics = true
    }
    
    func home() {
        let home = GKScene(fileNamed: "Home")!
        (home.rootNode as? SKScene)!.delegate = self
        presentScene(home.rootNode as? SKScene)
        
        (home.rootNode as? SKScene)!.addChild(player.component(ofType: Sprite.self)!.node)
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        player.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
}
