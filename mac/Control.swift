import GameplayKit

final class Control: GKComponent {
    var direction = Key.none
    
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    
    override func didAddToEntity() {
        let node = (entity as! Player).component(ofType: Sprite.self)!.node
        state = GKStateMachine(states: [
            Front0(node), Front1(node), Front2(node),
            Back0(node), Back1(node), Back2(node),
            Left0(node), Left1(node), Left2(node),
            Right0(node), Right1(node), Right2(node)])
        state.enter(Front0.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.25
            (state.currentState as! Stand).direction(direction)
            direction = .none
        }
    }
}
