import GameplayKit

final class Control: GKComponent {
    var direction = Key.none
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    
    override func didAddToEntity() {
        let node = entity!.component(ofType: Sprite.self)!.node
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
            move()
            direction = .none
        }
    }
    
    private func move() {
        if (state.currentState as! Stand).move(direction) {
            let sprite = entity!.component(ofType: Sprite.self)!
            var next = sprite.position
            switch direction {
            case .up: next.y += 1
            case .down: next.y -= 1
            case .left: next.x -= 1
            case .right: next.x += 1
            default: break
            }
            if (sprite.node.scene as! Scene).grid.node(atGridPosition: next) != nil {
                sprite.position = next
            }
        }
    }
}
