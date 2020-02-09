import Library
import GameplayKit

final class ControlWalk: GKComponent {
    fileprivate var node: SKSpriteNode { entity!.component(ofType: SpriteWalk.self)!.node }
    private weak var game: Game!
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    private var select: vector_int2 { memory.game.location.position &+ current.delta }
    private var current: _State { state.currentState as! _State }
    private var scene: WalkScene { player.node.scene as! WalkScene }
    private var dialog: DialogState { game.state.state(forClass: DialogState.self)! }
    private var unbox: UnboxState { game.state.state(forClass: UnboxState.self)! }
    private var menu: MenuState { game.state.state(forClass: MenuState.self)! }
    private var player: SpriteWalk { entity!.component(ofType: SpriteWalk.self)! }
    
    required init?(coder: NSCoder) { nil }
    init(_ game: Game) {
        super.init()
        state = .init(states: [
            Front0(self), Front1(self), Front2(self),
            Back0(self), Back1(self), Back2(self),
            Left0(self), Left1(self), Left2(self),
            Right0(self), Right1(self), Right2(self)])
        self.game = game
    }
    
    override func didAddToEntity() {
        enter(memory.game.location.facing, fallback: Front0.self)
    }
    
    func control(_ direction: Direction, _ action: Action) {
        switch action {
        case .ok:
            if let item = scene.chests[select] {
                unbox.next = WalkState.self
                unbox.position = select
                dialog.dialog = memory.take(chest: select, item: item)
                dialog.finish = UnboxState.self
                game.state.enter(DialogState.self)
            }
        case .cancel:
            menu.back = WalkState.self
            game.state.enter(MenuState.self)
        default: break
        }
        if current.compare == direction {
            if let door = scene.doors[select] {
                memory.game.location.id = door
                game.state.enter(WalkState.self)
            } else if scene.grid.node(atGridPosition: select) != nil {
                player.animate(select)
            }
            state.enter(current.next)
        } else if !(direction == .none && current.isFallback) {
            enter(direction, fallback: current.fallback)
        }
    }
    
    private func enter(_ direction: Direction, fallback: _State.Type) {
        switch direction {
        case .up: state.enter(Back0.self)
        case .left: state.enter(Left0.self)
        case .right: state.enter(Right0.self)
        case .down: state.enter(Front0.self)
        default: state.enter(fallback)
        }
    }
}

private class _State: GKState {
    var compare: Direction! { nil }
    var next: _State.Type! { nil }
    var fallback: _State.Type! { nil }
    var texture: String! { nil }
    var delta: vector_int2! { nil }
    var isFallback: Bool { false }
    private weak var state: ControlWalk!
    
    init(_ state: ControlWalk) {
        super.init()
        self.state = state
    }
    
    final override func didEnter(from: GKState?) {
        memory.game.location.facing = compare
        state.node.run(.setTexture(.init(imageNamed: "sh_normal_" + texture)))
    }
}

private class Front: _State {
    override var compare: Direction { .down }
    override var fallback: _State.Type { Front0.self }
    override var delta: vector_int2! { .init(0, -1) }
}

private class Back: _State {
    override var compare: Direction { .up }
    override var fallback: _State.Type { Back0.self }
    override var delta: vector_int2! { .init(0, 1) }
}

private class Left: _State {
    override var compare: Direction { .left }
    override var fallback: _State.Type { Left0.self }
    override var delta: vector_int2! { .init(-1, 0) }
}

private class Right: _State {
    override var compare: Direction { .right }
    override var fallback: _State.Type { Right0.self }
    override var delta: vector_int2! { .init(1, 0) }
}

private final class Front0: Front {
    override var texture: String { "front" }
    override var next: _State.Type { Front1.self }
    override var isFallback: Bool { true }
}

private final class Front1: Front {
    override var texture: String { "front_walk_a" }
    override var next: _State.Type { Front2.self }
}

private final class Front2: Front {
    override var texture: String { "front_walk_b" }
    override var next: _State.Type { Front1.self }
}

private final class Back0: Back {
    override var texture: String { "back" }
    override var next: _State.Type { Back1.self }
    override var isFallback: Bool { true }
}

private final class Back1: Back {
    override var texture: String { "back_walk_a" }
    override var next: _State.Type { Back2.self }
}

private final class Back2: Back {
    override var texture: String { "back_walk_b" }
    override var next: _State.Type { Back1.self }
}

private final class Left0: Left {
    override var texture: String { "left" }
    override var next: _State.Type { Left1.self }
    override var isFallback: Bool { true }
}

private final class Left1: Left {
    override var texture: String { "left_walk_a" }
    override var next: _State.Type { Left2.self }
}

private final class Left2: Left {
    override var texture: String { "left_walk_b" }
    override var next: _State.Type { Left1.self }
}

private final class Right0: Right {
    override var texture: String { "right" }
    override var next: _State.Type { Right1.self }
    override var isFallback: Bool { true }
}

private final class Right1: Right {
    override var texture: String { "right_walk_a" }
    override var next: _State.Type { Right2.self }
}

private final class Right2: Right {
    override var texture: String { "right_walk_b" }
    override var next: _State.Type { Right1.self }
}
