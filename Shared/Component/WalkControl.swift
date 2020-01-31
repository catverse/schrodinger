import Library
import GameplayKit

final class WalkControl: GKComponent {
    private weak var game: Game!
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    private var current: _State { state.currentState as! _State }
    private var select: vector_int2 { current.select() }
    private var scene: WalkScene { player.node.scene as! WalkScene }
    private var dialog: DialogState { game.state.state(forClass: DialogState.self)! }
    private var unbox: UnboxState { game.state.state(forClass: UnboxState.self)! }
    private var menu: MenuState { game.state.state(forClass: MenuState.self)! }
    private var player: WalkSprite { entity!.component(ofType: WalkSprite.self)! }
    
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    override func didAddToEntity() {
        let node = entity!.component(ofType: WalkSprite.self)!.node
        state = .init(states: [
            Front0(node), Front1(node), Front2(node),
            Back0(node), Back1(node), Back2(node),
            Left0(node), Left1(node), Left2(node),
            Right0(node), Right1(node), Right2(node)])
        state.enter(Front0.self)
    }
    
    func control(_ direction: Direction, _ action: Action) {
        if action == .ok {
            if let item = scene.chests[select] {
                unbox.next = WalkState.self
                unbox.position = select
                dialog.dialog = memory.take(chest: select, item: item)
                dialog.finish = UnboxState.self
                game.state.enter(DialogState.self)
            }
        } else if action == .cancel {
            menu.back = WalkState.self
            game.state.enter(MenuState.self)
        }
        if (state.currentState as! _State).move(direction) {
            if let door = scene.doors[select] {
                memory.game.location = door
                game.state.enter(WalkState.self)
            } else if scene.grid.node(atGridPosition: select) != nil {
                player.animate(select)
            }
        }
    }
}

private class _State: GKState {
    var compare: Direction! { nil }
    var texture: String! { nil }
    var next: AnyClass! { nil }
    var fallback: AnyClass! { nil }
    var delta: vector_int2! { nil }
    private weak var node: SKSpriteNode!
    
    init(_ node: SKSpriteNode) {
        super.init()
        self.node = node
    }
    
    final override func didEnter(from: GKState?) {
        memory.game.facing = compare
        node.run(.setTexture(.init(imageNamed: texture)))
    }
    
    final func select() -> vector_int2 {
        memory.game.position &+ delta
    }
    
    final func move(_ direction: Direction) -> Bool {
        if direction == compare {
            stateMachine!.enter(next)
            return true
        }
        switch direction {
        case .up: stateMachine!.enter(Back0.self)
        case .down: stateMachine!.enter(Front0.self)
        case .left: stateMachine!.enter(Left0.self)
        case .right: stateMachine!.enter(Right0.self)
        default: stateMachine!.enter(fallback)
        }
        return false
    }
}

private class Front: _State {
    override var compare: Direction { .down }
    override var fallback: AnyClass { Front0.self }
    override var delta: vector_int2! { .init(0, -1) }
}

private class Back: _State {
    override var compare: Direction { .up }
    override var fallback: AnyClass { Back0.self }
    override var delta: vector_int2! { .init(0, 1) }
}

private class Left: _State {
    override var compare: Direction { .left }
    override var fallback: AnyClass { Left0.self }
    override var delta: vector_int2! { .init(-1, 0) }
}

private class Right: _State {
    override var compare: Direction { .right }
    override var fallback: AnyClass { Right0.self }
    override var delta: vector_int2! { .init(1, 0) }
}

private final class Front0: Front {
    override var texture: String { "front" }
    override var next: AnyClass { Front1.self }
}

private final class Front1: Front {
    override var texture: String { "front_walk_a" }
    override var next: AnyClass { Front2.self }
}

private final class Front2: Front {
    override var texture: String { "front_walk_b" }
    override var next: AnyClass { Front1.self }
}

private final class Back0: Back {
    override var texture: String { "back" }
    override var next: AnyClass { Back1.self }
}

private final class Back1: Back {
    override var texture: String { "back_walk_a" }
    override var next: AnyClass { Back2.self }
}

private final class Back2: Back {
    override var texture: String { "back_walk_b" }
    override var next: AnyClass { Back1.self }
}

private final class Left0: Left {
    override var texture: String { "left" }
    override var next: AnyClass { Left1.self }
}

private final class Left1: Left {
    override var texture: String { "left_walk_a" }
    override var next: AnyClass { Left2.self }
}

private final class Left2: Left {
    override var texture: String { "left_walk_b" }
    override var next: AnyClass { Left1.self }
}

private final class Right0: Right {
    override var texture: String { "right" }
    override var next: AnyClass { Right1.self }
}

private final class Right1: Right {
    override var texture: String { "right_walk_a" }
    override var next: AnyClass { Right2.self }
}

private final class Right2: Right {
    override var texture: String { "right_walk_b" }
    override var next: AnyClass { Right1.self }
}
