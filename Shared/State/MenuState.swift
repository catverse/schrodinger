import Library
import GameplayKit

final class MenuState: State {
    var location: Location?
    var facing: Direction?
    var position: vector_int2?
    var back: State.Type!
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        cooldown = 1
        let scene = MenuScene()
        state = GKStateMachine(states: [Continue(scene), Inventory(scene), Save(scene), Exit(scene)])
        state.enter(Continue.self)
        scene.delegate = game
        game.presentScene(scene, transition: .fade(withDuration: 0.5))
    }
    
    override func willExit(to: GKState) {
        super.willExit(to: to)
        state = nil
    }
    
    override func control() {
        super.control()
        switch action.0 {
        case .ok: (state.currentState as! _State).ok()
        case .cancel:
            switch back {
            case is WalkState.Type:
                stateMachine!.state(forClass: WalkState.self)!.position = position
                stateMachine!.state(forClass: WalkState.self)!.facing = facing
                stateMachine!.state(forClass: WalkState.self)!.location = location
            default: break
            }
            stateMachine!.enter(back)
        default: break
        }
        
        switch direction.0 {
        case .up: (state.currentState as! _State).up()
        case .down: (state.currentState as! _State).down()
        default: break
        }
        
        action.0 = .none
        direction.0 = .none
    }
}

private class _State: GKState {
    fileprivate weak var scene: MenuScene!
    
    init(_ scene: MenuScene) {
        super.init()
        self.scene = scene
    }
    
    func ok() {
        
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
}

private final class Continue: _State {

}

private final class Inventory: _State {
    
}

private final class Save: _State {
    
}

private final class Exit: _State {
    
}