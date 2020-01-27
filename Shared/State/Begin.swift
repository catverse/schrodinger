import GameplayKit

final class Begin: State {
    private var state: GKStateMachine!
    
    override func didEnter(from: GKState?) {
        let start = game.scene as! Start
        state = GKStateMachine(states: [Press(start), New(start), Continue(start), List(start)])
        state.enter(Press.self)
    }
    
    override func control() {
        switch action {
        case .ok: (state.currentState as! BeginState).next()
        case .cancel: (state.currentState as! BeginState).previous()
        default: break
        }
        
        switch direction {
        case .up: (state.currentState as! BeginState).up()
        case .down: (state.currentState as! BeginState).down()
        default: break
        }
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
    
}
