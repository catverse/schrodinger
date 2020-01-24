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
        scene(GKScene(fileNamed: "House_Bedroom")!)
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
        let camera = SKCameraNode()
        camera.constraints = [.distance(.init(upperLimit: 100), to: player.component(ofType: Sprite.self)!.node)]
        (scene.rootNode as? SKScene)!.addChild(camera)
        (scene.rootNode as? SKScene)!.camera = camera
        (scene.rootNode as? SKScene)!.delegate = self
        (scene.rootNode as? SKScene)!.addChild(player.component(ofType: Sprite.self)!.node)
        player.component(ofType: Sprite.self)!.move((scene.rootNode as! Scene).start(nil))
        presentScene(scene.rootNode as? SKScene)
    }
}
