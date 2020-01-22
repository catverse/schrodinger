import GameplayKit

final class Control: GKComponent {
    var direction = Key.none
    private var state: GKStateMachine!
    
    override func didAddToEntity() {
        state = GKStateMachine(states: [Walk.Front(entity as! Player)])
    }
    
    override func update(deltaTime: TimeInterval) {
        state.update(deltaTime: deltaTime)
        state.enter(Walk.Front.self)
    }
}
