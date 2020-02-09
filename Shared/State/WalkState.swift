import Library
import GameplayKit

final class WalkState: State {
    private weak var controller: ControlWalk?
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        if game.scene!.name != memory.game.location.id.rawValue {
            let scene = GKScene(fileNamed: memory.game.location.id.rawValue)!.rootNode as! WalkScene
            let player = PlayerWalk(game)
            scene.entities.append(player)
            controller = player.component(ofType: ControlWalk.self)!
            let camera = SKCameraNode()
            camera.constraints = [.distance(.init(upperLimit: 100), to: player.component(ofType: SpriteWalk.self)!.node)]
            scene.addChild(camera)
            scene.camera = camera
            scene.delegate = game
            scene.addChild(player.component(ofType: SpriteWalk.self)!.node)
            if let location = game.scene as? WalkScene,
                let position = scene.starts[location.location] {
                memory.game.location.position = position
            }
            player.component(ofType: SpriteWalk.self)!.move(memory.game.location.position)
            game.presentScene(scene, transition: .fade(withDuration: 1.5))
        }
    }
    
    override func update(deltaTime: TimeInterval) {
        super.update(deltaTime: deltaTime)
        (game.scene as? WalkScene)?.entities.forEach { $0.update(deltaTime: deltaTime) }
    }
    
    override func control() {
        super.control()
        controller?.control(direction.0, action.0)
        direction.0 = direction.1
        action.0 = action.1
    }
}
