import GameplayKit

final class Control: GKComponent {
    weak var game: Game!
    var direction = Key.none
    private var timer = TimeInterval()
    private var state: GKStateMachine!
    
    override func didAddToEntity() {
        let node = entity!.component(ofType: Sprite.self)!.node
        state = .init(states: [
            Front0(node), Front1(node), Front2(node),
            Back0(node), Back1(node), Back2(node),
            Left0(node), Left1(node), Left2(node),
            Right0(node), Right1(node), Right2(node)])
        state.enter(Front0.self)
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.15
            let sprite = entity!.component(ofType: Sprite.self)!
            let scene = (sprite.node.scene as! Scene)
            interact(sprite, scene)
            move(sprite, scene)
            direction = .none
        }
    }
    
    private func interact(_ sprite: Sprite, _ scene: Scene) {
        if let door = scene.doors[sprite.position] {
            game.scene(door)
        }
    }
    
    private func move(_ sprite: Sprite, _ scene: Scene) {
        if (state.currentState as! Stand).move(direction) {
            var next = sprite.position
            switch direction {
            case .up: next.y += 1
            case .down: next.y -= 1
            case .left: next.x -= 1
            case .right: next.x += 1
            default: break
            }
            if scene.grid.node(atGridPosition: next) != nil {
                sprite.animate(next)
            }
        }
    }
}
