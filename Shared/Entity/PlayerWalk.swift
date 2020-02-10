import Library
import GameplayKit

final class PlayerWalk: GKEntity {
    let id = PlayerId.sh_normal
    
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        addComponent(SkinComponent(id.rawValue))
        addComponent(SpriteWalk())
        addComponent(FacingWalk())
        addComponent(ControlWalk(game))
    }
}
