import GameplayKit

class State: GKState {
    var direction = Direction.none
    var action = Action.none
    var timer = TimeInterval()
    private(set) weak var game: Game!
    
    override func didEnter(from: GKState?) {
        timer = 0
        direction = .none
        action = .none
    }
    
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        if timer <= 0 {
            timer = 0.1
            control()
        }
    }
    
    func control() {
        
    }
}
