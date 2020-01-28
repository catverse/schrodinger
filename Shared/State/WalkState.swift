import GameplayKit

final class WalkState: State {
    override func control() {
        game.player.component(ofType: WalkControl.self)!.control(direction.0, action.0)
        direction.0 = direction.1
        action.0 = action.1
    }
}
