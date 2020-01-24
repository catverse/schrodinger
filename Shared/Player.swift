import GameplayKit

final class Player: GKEntity {
    deinit {
        print("gone player")
    }
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        addComponent(Sprite())
        addComponent(Control())
    }
}
