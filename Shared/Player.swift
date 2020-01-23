import GameplayKit

final class Player: GKEntity {
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        addComponent(Sprite())
        addComponent(Control())
    }
}
