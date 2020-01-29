import Library
import GameplayKit
import Combine

final class StartState: State {
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        let scene = StartScene()
        state = GKStateMachine(states: [Press(scene), New(scene), Continue(scene), List(scene)])
        state.enter(Press.self)
        scene.delegate = game
        game.presentScene(scene, transition: .fade(withDuration: 3))
    }
    
    override func willExit(to: GKState) {
        super.willExit(to: to)
        state = nil
    }
    
    override func control() {
        super.control()
        switch action.0 {
        case .ok: (state.currentState as! _State).next()
        case .cancel: (state.currentState as! _State).previous()
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
    fileprivate weak var scene: StartScene!
    
    init(_ scene: StartScene) {
        super.init()
        self.scene = scene
    }
    
    func next() {
        
    }
    
    func previous() {
        
    }
    
    func up() {
        
    }
    
    func down() {
        
    }
}

private final class Press: _State {
    override func didEnter(from: GKState?) {
        scene.showPress()
    }
    
    override func next() {
        stateMachine!.enter(New.self)
    }
}

private final class New: _State {
    override func didEnter(from: GKState?) {
        scene.showNew()
    }
    
    override func next() {
        memory.new()
    }
    
    override func previous() {
        stateMachine!.enter(Press.self)
    }
    
    override func up() {
        stateMachine!.enter(Continue.self)
    }
    
    override func down() {
        stateMachine!.enter(Continue.self)
    }
}

private final class Continue: _State {
    override func didEnter(from: GKState?) {
        scene.showCont()
    }
    
    override func next() {
        stateMachine!.enter(List.self)
    }
    
    override func previous() {
        stateMachine!.enter(Press.self)
    }
    
    override func up() {
        stateMachine!.enter(New.self)
    }
    
    override func down() {
        stateMachine!.enter(New.self)
    }
}

private final class List: _State {
    private var entries = [Entry]()
    private var sub: AnyCancellable?
    private var index = Int()
    
    override func didEnter(from: GKState?) {
        scene.showList()
        index = -1
        sub = memory.entries.receive(on: DispatchQueue.main).sink { [weak self] in
            self?.scene.list($0)
            self?.entries = $0
        }
        memory.load()
    }
    
    override func willExit(to: GKState) {
        sub?.cancel()
    }
    
    override func next() {
        if index == -1 {
            stateMachine!.enter(Continue.self)
        } else {
            memory.game.value = entries[index]
        }
    }
    
    override func previous() {
        stateMachine!.enter(Continue.self)
    }
    
    override func up() {
        if !entries.isEmpty && index > -1 {
            index -= 1
            scene.scrollUp()
        }
    }
    
    override func down() {
        if index < entries.count - 1 {
            index += 1
            scene.scrollDown()
        }
    }
}
