import GameplayKit

class State: GKState {
    private(set) weak var game: Game!
    
    init(_ game: Game) {
        super.init()
        self.game = game
    }
    
    func direction(_ direction: Key) {
        
    }
}
