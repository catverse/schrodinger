import Library
import GameplayKit

final class WalkState: State {
    var position: vector_int2?
    var facing: Direction?
    private weak var controller: WalkControl?
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        if game.scene!.name != memory.game.location.rawValue {
            let scene = GKScene(fileNamed: memory.game.location.rawValue)!.rootNode as! WalkScene
            scene.player = .init(game)
            controller = scene.player.component(ofType: WalkControl.self)!
            let sprite = scene.player.component(ofType: WalkSprite.self)!
            let camera = SKCameraNode()
            camera.constraints = [.distance(.init(upperLimit: 100), to: sprite.node)]
            scene.addChild(camera)
            scene.camera = camera
            scene.delegate = game
            scene.addChild(sprite.node)
            
            if let position = self.position {
                sprite.move(position)
            } else {
                sprite.move(scene.start(game.scene))
            }
            
            game.presentScene(scene, transition: .fade(withDuration: 1.5))
            if facing != nil && facing != .down {
                controller!.control(facing!, .none)
            }
        }
        
        facing = nil
        position = nil
    }
    
    override func control() {
        super.control()
        controller?.control(direction.0, action.0)
        direction.0 = direction.1
        action.0 = action.1
    }
}
