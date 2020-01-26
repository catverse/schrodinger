import Foundation

final class Walk: State {
    override func update(deltaTime: TimeInterval) {
        game.player.update(deltaTime: deltaTime)
    }
    
    override func control(_ direction: Direction, _ action: Action) {
        game.player.component(ofType: WalkControl.self)!.direction = direction
        game.player.component(ofType: WalkControl.self)!.action = action
    }
}
