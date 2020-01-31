import Library
import GameplayKit

final class MenuState: State {
    var location: Location?
    var facing: Direction?
    var position: vector_int2?
    var back: State.Type!
    fileprivate weak var scene: MenuScene!
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        let scene = MenuScene()
        self.scene = scene
        state = GKStateMachine(states: [Continue(self), Inventory(self), Save(self), Exit(self), CancelSave(self), Overwrite(self), New(self)])
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
    
    fileprivate func cont() {
        switch back {
        case is WalkState.Type:
            stateMachine!.state(forClass: WalkState.self)!.position = position
            stateMachine!.state(forClass: WalkState.self)!.facing = facing
            stateMachine!.state(forClass: WalkState.self)!.location = location
        default: break
        }
        stateMachine!.enter(back)
    }
}

private class _State: GKState {
    fileprivate weak var menu: MenuState!
    
    init(_ menu: MenuState) {
        super.init()
        self.menu = menu
    }
    
    func ok() {
        
    }
    
    func cancel() {
        menu.cont()
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
}

private final class Continue: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showCont()
    }
    
    override func ok() {
        menu.cont()
    }
    
    override func down() {
        stateMachine!.enter(Inventory.self)
    }
}

private final class Inventory: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showInventory()
    }
    
    override func up() {
        stateMachine!.enter(Continue.self)
    }
    
    override func down() {
        stateMachine!.enter(Save.self)
    }
}

private final class Save: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showSave()
    }
    
    override func ok() {
        
    }
    
    override func up() {
        stateMachine!.enter(Inventory.self)
    }
    
    override func down() {
        stateMachine!.enter(Exit.self)
    }
}

private final class Exit: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showExit()
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class CancelSave: _State {
    override func didEnter(from: GKState?) {
        
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class Overwrite: _State {
    override func didEnter(from: GKState?) {
        
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class New: _State {
    override func didEnter(from: GKState?) {
        
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class CancelExit: _State {
    override func didEnter(from: GKState?) {
        
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class Confirm: _State {
    override func didEnter(from: GKState?) {
        
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}
