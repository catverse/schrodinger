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
        let pointing = (state.currentState as! WalkControlState).pointing(entity!.component(ofType: WalkSprite.self)!.position)
        if action == .ok {
        if let item = (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).items[pointing] {
                print(item)
//                game.state.enter(Dialog.self)
                game.message.isHidden = false
            }
        }
        if (state.currentState as! WalkControlState).move(direction) {
            if let door = (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).doors[pointing] {
                game.scene(door)
            } else if (entity!.component(ofType: WalkSprite.self)!.node.scene as! Scene).grid.node(atGridPosition: pointing) != nil {
                entity!.component(ofType: WalkSprite.self)!.animate(pointing)
            }
        }
    }
}
