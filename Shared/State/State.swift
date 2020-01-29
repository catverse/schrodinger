import GameplayKit

class State: GKState {
    var cooldown = TimeInterval()
    var direction = (Direction.none, Direction.none)
    var action = (Action.none, Action.none)
    private(set) weak var game: Game!
    private var timer = TimeInterval()
    
    override func didEnter(from: GKState?) {
        timer = 0
        direction = (.none, .none)
        action = (.none, .none)
    }
    
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    override func update(deltaTime: TimeInterval) {
        timer -= deltaTime
        cooldown -= deltaTime
        if timer <= 0 {
            timer = 0.15
            if cooldown < 0 {
                control()
            } else {
                direction = (.none, .none)
                action = (.none, .none)
            }
        }
    }
    
    func control() {
        
    }
}
