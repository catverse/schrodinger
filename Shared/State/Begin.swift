import Library
import GameplayKit
import Combine

final class Begin: State {
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        let start = game.scene as! Start
        state = GKStateMachine(states: [Press(start), New(start), Continue(start), List(start)])
        state.enter(Press.self)
    }
    
    override func control() {
        switch action.0 {
        case .ok: (state.currentState as! BeginState).next()
        case .cancel: (state.currentState as! BeginState).previous()
        default: break
        }
        
        switch direction.0 {
        case .up: (state.currentState as! BeginState).up()
        case .down: (state.currentState as! BeginState).down()
        default: break
        }
        
        action.0 = .none
        direction.0 = .none
    }
}

private class BeginState: GKState {
    fileprivate weak var start: Start!
    
    init(_ start: Start) {
        super.init()
        self.start = start
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

private final class Press: BeginState {
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        start.showPress()
    }
    
    override func next() {
        stateMachine!.enter(New.self)
    }
}

private final class New: BeginState {
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        start.showNew()
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

private final class Continue: BeginState {
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        start.showCont()
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

private final class List: BeginState {
    private var entries = [Entry]()
    private var sub: AnyCancellable?
    private var index = Int()
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        start.showList()
        index = -1
        sub = memory.entries.receive(on: DispatchQueue.main).sink { [weak self] in
            self?.start.list($0)
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
            start.scrollUp()
        }
    }
    
    override func down() {
        if index < entries.count - 1 {
            index += 1
            start.scrollDown()
        }
    }
}
