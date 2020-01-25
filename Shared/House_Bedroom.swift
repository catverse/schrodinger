import GameplayKit

final class House_Bedroom: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 100, height: 100, diagonalsAllowed: false)
    let doors = [vector_int2(14, 4) : "House_Corridor"]
    
    func start(_ from: SKScene?) -> vector_int2 {
        switch from {
        case is House_Corridor:
            return vector_int2(14, 5)
        default:
            return vector_int2(1, 3)
        }
    }
}
