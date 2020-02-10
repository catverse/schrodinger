import Library
import GameplayKit

final class NpcWalk: GKEntity {
    let id: NpcId
    let tag: Int
    
    required init?(coder: NSCoder) { nil }
    init(_ id: NpcId, tag: Int) {
        self.id = id
        self.tag = tag
        super.init()
        addComponent(SkinComponent(id.rawValue))
        addComponent(SpriteWalk())
        addComponent(FacingWalk())
        addComponent(StandingWalk())
    }
}
