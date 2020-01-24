import GameplayKit

final class WalkPlayer: GKEntity {
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        addComponent(WalkSprite())
        addComponent(WalkControl(game))
    }
}
