import Library
import GameplayKit

final class House_Bedroom: SKScene, WalkScene {
    var player: WalkPlayer!
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 18, height: 15, diagonalsAllowed: false)
    let doors = [vector_int2(14, 3) : Location.House_Corridor]
    let chests = [vector_int2(7, 11) : Item.Potion]
    let unboxed = "house_chest_open"
    
    func start(_ from: SKScene?) -> vector_int2 {
        switch from {
        case is House_Corridor:
            return vector_int2(14, 5)
        default:
            return vector_int2(1, 10)
        }
    }
    
    override func didMove(to: SKView) {
        configure()
    }
}
