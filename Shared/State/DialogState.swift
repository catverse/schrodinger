import GameplayKit

final class DialogState: State {
    override func didEnter(from: GKState?) {
        game.scene!.camera!.addChild(DialogNode(game.bounds))
    }
    
    override func willExit(to: GKState) {
        game.scene!.camera!.children.first { $0 is DialogNode }!.removeFromParent()
    }
    
    override func update(deltaTime: TimeInterval) {
//        game.player.update(deltaTime: deltaTime)
    }
}
