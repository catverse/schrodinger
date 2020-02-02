import GameplayKit

final class InventoryState: State {
    fileprivate weak var scene: InventoryScene!
    private var state: GKStateMachine!
    
    override init(_ game: Game) {
        super.init(game)
        state = .init(states: [Back(self), Items(self), Key(self), ItemsEmpty(self), KeyEmpty(self)])
    }
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        let scene = InventoryScene()
        scene.delegate = game
        self.scene = scene
        items()
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
            case .left: (state.currentState as! _State).left()
            case .right: (state.currentState as! _State).right()
            default: break
            }
        }
        
        action.0 = .none
        direction.0 = .none
    }
    
    fileprivate func back() {
        stateMachine!.enter(MenuState.self)
    }
    
    fileprivate func items() {
//        state.enter(memory.game.inventory.isEmpty ? ItemsEmpty.self : Items.self)
        state.enter(Items.self)
        scene.list(["a", "b", "hello", "world", "lorem", "ipsum"])
        
    }
    
    fileprivate func key() {
        state.enter(KeyEmpty.self)
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
        state.back()
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
    
    func left() {
        
    }
    
    func right() {
        
    }
}

private final class Back: _State {
    override func didEnter(from: GKState?) {
        state.scene.showBack()
    }
    
    override func ok() {
        state.back()
    }
    
    override func right() {
        state.items()
    }
}

private final class Items: _State {
    override func didEnter(from: GKState?) {
        state.scene.showItems()
    }
    
    override func left() {
        stateMachine!.enter(Back.self)
    }
    
    override func right() {
        state.key()
    }
}

private final class ItemsEmpty: _State {
    override func didEnter(from: GKState?) {
        state.scene.showItemsEmpty()
    }
    
    override func left() {
        stateMachine!.enter(Back.self)
    }
    
    override func right() {
        state.key()
    }
}

private final class Key: _State {
    override func didEnter(from: GKState?) {
        state.scene.showKey()
    }
    
    override func left() {
        state.items()
    }
}

private final class KeyEmpty: _State {
    override func didEnter(from: GKState?) {
        state.scene.showKeyEmpty()
    }
    
    override func left() {
        state.items()
    }
}
