import GameplayKit

final class Dialog: State {
    
    override func didEnter(from previousState: GKState?) {
        game.message.isHidden = false
    }
    
    override func update(deltaTime: TimeInterval) {
//        game.player.update(deltaTime: deltaTime)
    }
}
