import Library
import GameplayKit

class State: GKState {
    var direction = (Direction.none, Direction.none)
    var action = (Action.none, Action.none)
    private(set) weak var game: Game!
    private var timer = TimeInterval()
    
    override func didEnter(from: GKState?) {
        direction = (.none, .none)
        action = (.none, .none)
    }
    
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.15
            control()
        }
    }
    
    func control() {
        
    }
}
