import GameplayKit

final class WalkControl: GKComponent {
    private weak var game: Game!
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    
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
        let pointing = (state.currentState as! WalkState).pointing(entity!.component(ofType: WalkSprite.self)!.position)
        if action == .ok {
            if let item = (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).items[pointing] {
                game.state.enter(Dialog.self)
            }
        }
        if (state.currentState as! WalkState).move(direction) {
            if let door = (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).doors[pointing] {
                game.scene(door)
            } else if (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).grid.node(atGridPosition: pointing) != nil {
                entity!.component(ofType: WalkSprite.self)!.animate(pointing)
            }
        }
    }
}

private class WalkState: GKState {
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
        node.run(.setTexture(.init(imageNamed: texture)))
    }
    
    final func pointing(_ tile: vector_int2) -> vector_int2 {
        tile &+ delta
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

private class Front: WalkState {
    override var compare: Direction { .down }
    override var fallback: AnyClass { Front0.self }
    override var delta: vector_int2! { .init(0, -1) }
}

private class Back: WalkState {
    override var compare: Direction { .up }
    override var fallback: AnyClass { Back0.self }
    override var delta: vector_int2! { .init(0, 1) }
}

private class Left: WalkState {
    override var compare: Direction { .left }
    override var fallback: AnyClass { Left0.self }
    override var delta: vector_int2! { .init(-1, 0) }
}

private class Right: WalkState {
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
