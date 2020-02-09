import GameplayKit

final class NpcWalk: GKEntity {
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        addComponent(SpriteWalk())
    }
}
