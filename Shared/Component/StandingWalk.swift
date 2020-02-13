import Library
import GameplayKit

final class StandingWalk: GKComponent {
    fileprivate var facing: FacingWalk { entity!.component(ofType: FacingWalk.self)! }
    private var state: GKStateMachine!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        state = .init(states: [Waiting(self), Conversation(self)])
        waiting()
    }
    
    override func update(deltaTime: TimeInterval) {
        state.update(deltaTime: deltaTime)
    }
    
    func conversation(_ direction: Direction) {
        state.enter(Conversation.self)
        switch direction {
        case .down: facing.enter(.up)
        case .left: facing.enter(.right)
        case .right: facing.enter(.left)
        default: facing.enter(.down)
        }
    }
    
    func waiting() {
        state.enter(Waiting.self)
    }
}

private class _State: GKState {
    private(set) weak var state: StandingWalk!
    
    init(_ state: StandingWalk) {
        super.init()
        self.state = state
    }
}

private class Waiting: _State {
    private var timeout = TimeInterval()
    
    override func update(deltaTime: TimeInterval) {
        timeout -= deltaTime
        if timeout < 0 {
            timeout = 1
            if Int.random(in: 0 ... 9) == 0 {
                var direction = Direction.none
                if Int.random(in: 0 ... 1) == 0 {
                    switch state.facing.compare {
                    case .down: direction = .right
                    case .right: direction = .up
                    case .up: direction = .left
                    case .left:  direction = .down
                    default: break
                    }
                } else {
                    switch state.facing.compare {
                    case .down: direction = .left
                    case .left: direction = .up
                    case .up: direction = .right
                    case .right:  direction = .down
                    default: break
                    }
                }
                state.facing.enter(direction)
            }
        }
    }
}

private class Conversation: _State {
    
}
