import SpriteKit
import GameplayKit

class Game: SKView, SKSceneDelegate {
    let player = Player()
    private var time = TimeInterval()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsPhysics = true
        player.component(ofType: Control.self)!.game = self
    }
    
    func scene(_ name: String) {
        time = 0
        let scene = GKScene(fileNamed: name)!.rootNode as! Scene
        let camera = SKCameraNode()
        camera.constraints = [.distance(.init(upperLimit: 100), to: player.component(ofType: Sprite.self)!.node)]
        scene.addChild(camera)
        scene.camera = camera
        scene.delegate = self
        scene.addChild(player.component(ofType: Sprite.self)!.node)
        player.component(ofType: Sprite.self)!.move(scene.start(nil))
        presentScene(scene, transition: .fade(withDuration: 1))
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        player.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
}
