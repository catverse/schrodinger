import Library
import GameplayKit
import Combine

let memory = Memory()

class Game: SKView, SKSceneDelegate {
    private(set) var state: GKStateMachine!
    private var time = TimeInterval()
    private var subs = Set<AnyCancellable>()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        state = .init(states: [StartState(self), WalkState(self), DialogState(self), UnboxState(self), MenuState(self)])
        memory.game.receive(on: DispatchQueue.main).sink {
            if let game = $0 {
                if game.location.rawValue != self.scene?.name {
                    self.state.state(forClass: WalkState.self)!.location = game.location
                    self.state.enter(WalkState.self)
                }
            } else {
                self.state.enter(StartState.self)
            }
        }.store(in: &subs)
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        state.update(deltaTime: self.time == 0 ? 0 : time - self.time)
        self.time = time
    }
}
