import GameplayKit

class Walk: GKState {
    private weak var player: Player!
    
    final class Front: Walk {
        
    }
    
    final class Left: Walk {
        
    }
    
    final class Right: Walk {
        
    }
    
    init(_ player: Player) {
        super.init()
        self.player = player
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        print("update")
    }
}
