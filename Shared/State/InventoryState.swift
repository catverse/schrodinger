import GameplayKit

final class InventoryState: State {
    var back: State.Type!
    fileprivate weak var scene: MenuScene!
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        let scene = MenuScene()
        self.scene = scene
        state = GKStateMachine(states: [Continue(self)])
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
        case .cancel: (state.currentState as! _State).cancel()
        default:
            switch direction.0 {
            case .up: (state.currentState as! _State).up()
            case .down: (state.currentState as! _State).down()
            default: break
            }
        }
        
        action.0 = .none
        direction.0 = .none
    }
    
    fileprivate func cont() {
        stateMachine!.enter(back)
    }
    
    fileprivate func exit() {
        stateMachine!.enter(StartState.self)
    }
}

private class _State: GKState {
    fileprivate weak var state: InventoryState!
    
    init(_ state: InventoryState) {
        super.init()
        self.state = state
    }
    
    func ok() {
        
    }
    
    func cancel() {
//        menu.cont()
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
}

private final class Continue: _State {
    override func didEnter(from: GKState?) {
    }
    
    override func ok() {
    }
    
    override func down() {
    }
}
