import Library
import GameplayKit

final class ControlWalk: GKComponent {
    private weak var game: Game!
    private var facing: FacingWalk { entity!.component(ofType: FacingWalk.self)! }
    private var scene: WalkScene { sprite.node.scene as! WalkScene }
    private var dialog: DialogState { game.state.state(forClass: DialogState.self)! }
    private var unbox: UnboxState { game.state.state(forClass: UnboxState.self)! }
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
                unbox.next = WalkState.self
                unbox.position = select
                dialog.dialog = memory.take(chest: select, item: item.0)
                dialog.finish = UnboxState.self
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
