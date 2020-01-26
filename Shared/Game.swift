import GameplayKit

class Game: SKView, SKSceneDelegate {
    private(set) var player: GKEntity!
    private(set) var state: GKStateMachine!
    private(set) weak var message: Message!
    private var time = TimeInterval()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        showsFPS = true
        showsNodeCount = true
        showsDrawCount = true
        state = .init(states: [Wait(self), Walk(self), Dialog(self)])
    }
    
    func scene(_ name: String) {
        state.enter(Wait.self)
        time = 0
        player = WalkPlayer(self)
        let scene = GKScene(fileNamed: name)!.rootNode as! Scene
        let sprite = player.component(ofType: WalkSprite.self)!
        let camera = SKCameraNode()
        camera.constraints = [.distance(.init(upperLimit: 100), to: sprite.node)]
        scene.addChild(camera)
        scene.camera = camera
        scene.delegate = self
        scene.addChild(sprite.node)
        sprite.move(scene.start(self.scene))
        
        let message = Message()
        message.bound(bounds)
        camera.addChild(message)
        self.message = message
        
        presentScene(scene, transition: .fade(withDuration: 2))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.state.enter(Walk.self)
        }
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        state.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
}
