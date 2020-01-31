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
        state = GKStateMachine(states: [Continue(self), Inventory(self), Save(self), Exit(self), CancelSave(self), Overwrite(self), New(self), Saved(self), CancelExit(self), Confirm(self)])
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
        switch back {
        case is WalkState.Type:
            stateMachine!.state(forClass: WalkState.self)!.position = position
            stateMachine!.state(forClass: WalkState.self)!.facing = facing
        default: break
        }
        stateMachine!.enter(back)
    }
    
    fileprivate func exit() {
        stateMachine!.enter(StartState.self)
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
        stateMachine!.enter(Overwrite.self)
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
    
    override func ok() {
        stateMachine!.enter(Confirm.self)
    }
    
    override func up() {
        stateMachine!.enter(Save.self)
    }
}

private final class CancelSave: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showCancelSave()
    }
    
    override func ok() {
        stateMachine!.enter(Save.self)
    }
    
    override func cancel() {
        stateMachine!.enter(Save.self)
    }
    
    override func up() {
        stateMachine!.enter(New.self)
    }
}

private final class Overwrite: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showOverwrite()
    }
    
    override func ok() {
        memory.save()
        stateMachine!.enter(Saved.self)
    }
    
    override func cancel() {
        stateMachine!.enter(Save.self)
    }
    
    override func down() {
        stateMachine!.enter(New.self)
    }
}

private final class New: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showNew()
    }
    
    override func ok() {
        memory.duplicate()
        stateMachine!.enter(Saved.self)
    }
    
    override func cancel() {
        stateMachine!.enter(Save.self)
    }
    
    override func up() {
        stateMachine!.enter(Overwrite.self)
    }
    
    override func down() {
        stateMachine!.enter(CancelSave.self)
    }
}

private final class CancelExit: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showCancelExit()
    }
    
    override func ok() {
        stateMachine!.enter(Exit.self)
    }
    
    override func cancel() {
        stateMachine!.enter(Exit.self)
    }
    
    override func up() {
        stateMachine!.enter(Confirm.self)
    }
}

private final class Confirm: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showConfirm()
    }
    
    override func ok() {
        memory.game = nil
        menu.exit()
    }
    
    override func cancel() {
        stateMachine!.enter(Exit.self)
    }
    
    override func down() {
        stateMachine!.enter(CancelExit.self)
    }
}

private final class Saved: _State {
    override func didEnter(from: GKState?) {
        menu.scene.showSaved()
    }
    
    override func ok() {
        menu.cont()
    }
}
