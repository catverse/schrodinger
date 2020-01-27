import GameplayKit

final class Walk: State {
    override func control() {
        game.player.component(ofType: WalkControl.self)!.control(direction, action)
    }
}
