import Library
import GameplayKit

final class StandingWalk: GKComponent {
    private var state: GKStateMachine!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init()
        state = .init(states: [Waiting(self), Conversation(self)])
        state.enter(Waiting.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        state.update(deltaTime: deltaTime)
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
    private var facing: FacingWalk { state.entity!.component(ofType: FacingWalk.self)! }
    private var timeout = TimeInterval()
    
    override func update(deltaTime: TimeInterval) {
        timeout -= deltaTime
        if timeout < 0 {
            timeout = 1
            if Int.random(in: 0 ... 9) == 0 {
                var direction = Direction.none
                if Int.random(in: 0 ... 1) == 0 {
                    switch facing.compare {
                    case .down: direction = .right
                    case .right: direction = .up
                    case .up: direction = .left
                    case .left:  direction = .down
                    default: break
                    }
                } else {
                    switch facing.compare {
                    case .down: direction = .left
                    case .left: direction = .up
                    case .up: direction = .right
                    case .right:  direction = .down
                    default: break
                    }
                }
                facing.enter(direction)
            }
        }
    }
}

private class Conversation: _State {
    
}
