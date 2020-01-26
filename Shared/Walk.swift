import Foundation

final class Walk: State {
    override func update(deltaTime: TimeInterval) {
        game.player.update(deltaTime: deltaTime)
    }
    
    override func direction(_ direction: Direction) {
        game.player.component(ofType: WalkControl.self)!.direction = direction
    }
}
