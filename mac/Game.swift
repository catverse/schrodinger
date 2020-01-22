import SpriteKit
import GameplayKit

final class Game: SKView, SKSceneDelegate {
    private var time = TimeInterval()
    private let player = Player()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsPhysics = true
    }
    
    func home() {
        scene(GKScene(fileNamed: "Home")!)
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        player.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
    
    override func keyDown(with: NSEvent) {
        player.component(ofType: Control.self)!.direction = Key(rawValue: with.keyCode) ?? .none
    }
    
    private func scene(_ scene: GKScene) {
        time = 0
        (scene.rootNode as? SKScene)!.delegate = self
        presentScene(scene.rootNode as? SKScene)
        (scene.rootNode as? SKScene)!.addChild(player.component(ofType: Sprite.self)!.node)
    }
}
