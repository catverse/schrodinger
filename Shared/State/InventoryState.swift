import GameplayKit

final class InventoryState: State {
    fileprivate weak var scene: InventoryScene!
    private var index = 0
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
        if memory.game.inventory.isEmpty {
            state.enter(ItemsEmpty.self)
        } else {
            state.enter(Items.self)
            index = 0
            scene.list(memory.game.inventory.map { .key("Item.\($0.0.rawValue)") + " x\($0.1)" })
        }
    }
    
    fileprivate func key() {
        state.enter(KeyEmpty.self)
    }
    
    fileprivate func up() {
        if index > 0 {
            index -= 1
            scene.cat(index)
            if scene.convert(.zero, from: scene.cat).y > 50 {
                scene.scrollUp()
            }
        }
    }
    
    fileprivate func down() {
        if scene._items.count - 1 > index {
            index += 1
            scene.cat(index)
            if scene.convert(.zero, from: scene.cat).y < -85 {
                scene.scrollDown()
            }
        }
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
    
    override func up() {
        state.up()
    }
    
    override func down() {
        state.down()
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
    
    override func up() {
        state.up()
    }
    
    override func down() {
        state.down()
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
