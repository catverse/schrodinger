import GameplayKit

final class Control: GKComponent {
    var direction = Key.none
    
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    
    override func didAddToEntity() {
        let node = (entity as! Player).component(ofType: Sprite.self)!.node
        state = GKStateMachine(states: [Front(node), Left(node), LeftA(node), LeftB(node), Right(node), RightA(node), RightB(node)])
        state.enter(Front.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.25
            switch direction {
            case .down: state.enter(Front.self)
            case .left:
                switch state.currentState {
                case is Left, is LeftB:
                    state.enter(LeftA.self)
                case is LeftA:
                    state.enter(LeftB.self)
                default:
                    state.enter(Left.self)
                }
            case .right:
                switch state.currentState {
                case is Right, is RightB:
                    state.enter(RightA.self)
                case is RightA:
                    state.enter(RightB.self)
                default:
                    state.enter(Right.self)
                }
            case .none:
                switch state.currentState {
                case is LeftA, is LeftB:
                    state.enter(Left.self)
                case is RightA, is RightB:
                    state.enter(Right.self)
                default: break
                }
            default: break
            }
            direction = .none
        }
    }
}
