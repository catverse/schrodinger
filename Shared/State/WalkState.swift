import Library
import GameplayKit

final class WalkState: State {
    private weak var controller: WalkControl?
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        if game.scene!.name != memory.game.location.id.rawValue {
            let scene = GKScene(fileNamed: memory.game.location.id.rawValue)!.rootNode as! WalkScene
            scene.player = .init(game)
            controller = scene.player.component(ofType: WalkControl.self)!
            let sprite = scene.player.component(ofType: WalkSprite.self)!
            let camera = SKCameraNode()
            camera.constraints = [.distance(.init(upperLimit: 100), to: sprite.node)]
            scene.addChild(camera)
            scene.camera = camera
            scene.delegate = game
            scene.addChild(sprite.node)
            if let location = game.scene as? WalkScene,
                let position = scene.starts[location.location] {
                memory.game.location.position = position
            }
            sprite.move(memory.game.location.position)
            game.presentScene(scene, transition: .fade(withDuration: 1.5))
        }
    }
    
    override func control() {
        super.control()
        controller?.control(direction.0, action.0)
        direction.0 = direction.1
        action.0 = action.1
    }
}
