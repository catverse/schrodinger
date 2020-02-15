import Library
import GameplayKit

final class ControlWalk: GKComponent {
    private weak var game: Game!
    private var facing: FacingWalk { entity!.component(ofType: FacingWalk.self)! }
    private var scene: WalkScene { sprite.node.scene as! WalkScene }
    private var dialog: DialogState { game.state.state(forClass: DialogState.self)! }
    private var menu: MenuState { game.state.state(forClass: MenuState.self)! }
    private var sprite: SpriteWalk { entity!.component(ofType: SpriteWalk.self)! }
    private var select: vector_int2 { memory.game.location.position &+ facing.delta }
    
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    func control(_ direction: Direction, _ action: Action) {
        switch action {
        case .ok:
            if let item = scene.chests[select] {
                dialog.unbox = select
                dialog.dialog = memory.take(chest: select, item: item.0)
                game.state.enter(DialogState.self)
            } else if let npc = scene.npc.enumerated().first(where: { $0.1.1 == select }) {
                dialog.restore = scene.entities.compactMap { $0 as? NpcWalk }.first { $0.tag == npc.0 }
                dialog.restore!.component(ofType: StandingWalk.self)!.conversation(facing.compare)
                dialog.dialog = scene.dialog(npc.0)
                game.state.enter(DialogState.self)
            }
        case .cancel:
            menu.back = WalkState.self
            game.state.enter(MenuState.self)
        default: break
        }
        if facing.compare == direction {
            if let door = scene.doors[select] {
                memory.game.location.id = door
                game.state.enter(WalkState.self)
            } else if scene.grid.node(atGridPosition: select) != nil {
                memory.game.location.position = select
                sprite.animate(memory.game.location.position)
            }
            facing.next()
        } else {
            facing.enter(direction)
        }
    }
}
