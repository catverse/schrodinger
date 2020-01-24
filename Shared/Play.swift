import Foundation

final class Play: State {
    override func update(deltaTime: TimeInterval) {
        game.player.update(deltaTime: deltaTime)
    }
}
