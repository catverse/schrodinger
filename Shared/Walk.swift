import GameplayKit

final class Walk: State {
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.15
            game.player.component(ofType: WalkControl.self)!.control(direction, action)
        }
    }
}
