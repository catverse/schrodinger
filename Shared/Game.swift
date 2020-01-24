import GameplayKit

class Game: SKView, SKSceneDelegate {
    private(set) var player: Player!
    private var time = TimeInterval()
    private var state: GKStateMachine!
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsPhysics = true
        state = .init(states: [Wait(self), Play(self)])
    }
    
    func scene(_ name: String) {
        state.enter(Wait.self)
        time = 0
        player = Player()
        player.component(ofType: Control.self)!.game = self
        let scene = GKScene(fileNamed: name)!.rootNode as! Scene
        let sprite = player.component(ofType: Sprite.self)!
        let camera = SKCameraNode()
        camera.constraints = [.distance(.init(upperLimit: 100), to: sprite.node)]
        scene.addChild(camera)
        scene.camera = camera
        scene.delegate = self
        
        presented(scene, sprite)
        self.presentScene(scene, transition: .fade(withDuration: 2))
        
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        state.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
    
    private func presented(_ scene: Scene, _ sprite: Sprite) {
        scene.addChild(sprite.node)
        sprite.move(scene.start(nil))
        state.enter(Play.self)
    }
}
