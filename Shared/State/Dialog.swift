import GameplayKit

final class Dialog: State {
    override func didEnter(from: GKState?) {
        game.scene!.camera!.addChild(Message(game.bounds))
    }
    
    override func willExit(to: GKState) {
        game.scene!.camera!.children.first { $0 is Message }!.removeFromParent()
    }
    
    override func update(deltaTime: TimeInterval) {
//        game.player.update(deltaTime: deltaTime)
    }
}
