import GameplayKit

final class PlayerWalk: GKEntity {
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        addComponent(SpriteWalk())
        addComponent(ControlWalk(game))
    }
}
