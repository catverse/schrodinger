import Library
import GameplayKit

final class MenuState: State {
    var back: State.Type!
    fileprivate weak var scene: MenuScene!
    private var state: GKStateMachine!
    
    override init(_ game: Game) {
        super.init(game)
        state = .init(states: [Continue(self), Inventory(self), Save(self), Exit(self), CancelSave(self), Overwrite(self), New(self), Saved(self), CancelExit(self), Confirm(self)])
    }
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        let scene = MenuScene()
        scene.delegate = game
        self.scene = scene
        state.enter(Continue.self)
        game.presentScene(scene, transition: .fade(withDuration: 0.5))
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
    
    fileprivate func inventory() {
        stateMachine!.enter(InventoryState.self)
    }
}

private class _State: GKState {
    fileprivate weak var state: MenuState!
    
    init(_ state: MenuState) {
        super.init()
        self.state = state
    }
    
    func ok() {
        
    }
    
    func cancel() {
        state.cont()
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
}

private final class Continue: _State {
    override func didEnter(from: GKState?) {
        state.scene.showCont()
    }
    
    override func ok() {
        state.cont()
    }
    
    override func down() {
        stateMachine!.enter(Inventory.self)
    }
}

private final class Inventory: _State {
    override func didEnter(from: GKState?) {
        state.scene.showInventory()
    }
    
    override func ok() {
        state.inventory()
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
        state.scene.showSave()
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
        state.scene.showExit()
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
        state.scene.showCancelSave()
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
        state.scene.showOverwrite()
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
        state.scene.showNew()
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
        state.scene.showCancelExit()
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
        state.scene.showConfirm()
    }
    
    override func ok() {
        memory.game = nil
        state.exit()
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
        state.scene.showSaved()
    }
    
    override func ok() {
        state.cont()
    }
}
