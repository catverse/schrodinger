import GameplayKit

final class WalkControl: GKComponent {
    var direction = Direction.none
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
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.15
            if (state.currentState as! WalkState).move(direction) {
                var next = entity!.component(ofType: WalkSprite.self)!.position
                switch direction {
                case .up: next.y += 1
                case .down: next.y -= 1
                case .left: next.x -= 1
                case .right: next.x += 1
                default: break
                }
                if let door = (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).doors[next] {
                    game.scene(door)
                } else if (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).grid.node(atGridPosition: next) != nil {
                    entity!.component(ofType: WalkSprite.self)!.animate(next)
                }
            }
            direction = .none
        }
    }
}
