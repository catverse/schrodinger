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
}
