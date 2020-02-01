import Library
import GameplayKit

let memory = Memory()

class Game: SKView, SKSceneDelegate {
    private(set) var state: GKStateMachine!
    private var time = TimeInterval()
    
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        ignoresSiblingOrder = true
        state = .init(states: [StartState(self), WalkState(self), DialogState(self), UnboxState(self), MenuState(self), InventoryState(self)])
        state.enter(StartState.self)
    }
    
    func update(_ time: TimeInterval, for: SKScene) {
        let delta = self.time == 0 ? 0 : time - self.time
        state.update(deltaTime: delta)
        memory.game?.time += delta
        self.time = time
    }
}
