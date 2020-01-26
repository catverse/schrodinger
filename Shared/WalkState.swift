import GameplayKit

class WalkState: GKState {
    fileprivate var compare: Direction! { nil }
    fileprivate var texture: String! { nil }
    fileprivate var next: AnyClass! { nil }
    fileprivate var fallback: AnyClass! { nil }
    fileprivate var delta: vector_int2! { nil }
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

class Front: WalkState {
    override var compare: Direction { .down }
    override var fallback: AnyClass { Front0.self }
    override var delta: vector_int2! { .init(0, -1) }
}

class Back: WalkState {
    override var compare: Direction { .up }
    override var fallback: AnyClass { Back0.self }
    override var delta: vector_int2! { .init(0, 1) }
}

class Left: WalkState {
    override var compare: Direction { .left }
    override var fallback: AnyClass { Left0.self }
    override var delta: vector_int2! { .init(-1, 0) }
}

class Right: WalkState {
    override var compare: Direction { .right }
    override var fallback: AnyClass { Right0.self }
    override var delta: vector_int2! { .init(1, 0) }
}

final class Front0: Front {
    override var texture: String { "front" }
    override var next: AnyClass { Front1.self }
}

final class Front1: Front {
    override var texture: String { "front_walk_a" }
    override var next: AnyClass { Front2.self }
}

final class Front2: Front {
    override var texture: String { "front_walk_b" }
    override var next: AnyClass { Front1.self }
}

final class Back0: Back {
    override var texture: String { "back" }
    override var next: AnyClass { Back1.self }
}

final class Back1: Back {
    override var texture: String { "back_walk_a" }
    override var next: AnyClass { Back2.self }
}

final class Back2: Back {
    override var texture: String { "back_walk_b" }
    override var next: AnyClass { Back1.self }
}

final class Left0: Left {
    override var texture: String { "left" }
    override var next: AnyClass { Left1.self }
}

final class Left1: Left {
    override var texture: String { "left_walk_a" }
    override var next: AnyClass { Left2.self }
}

final class Left2: Left {
    override var texture: String { "left_walk_b" }
    override var next: AnyClass { Left1.self }
}

final class Right0: Right {
    override var texture: String { "right" }
    override var next: AnyClass { Right1.self }
}

final class Right1: Right {
    override var texture: String { "right_walk_a" }
    override var next: AnyClass { Right2.self }
}

final class Right2: Right {
    override var texture: String { "right_walk_b" }
    override var next: AnyClass { Right1.self }
}
