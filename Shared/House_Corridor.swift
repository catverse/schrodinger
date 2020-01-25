import GameplayKit

final class House_Corridor: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 100, height: 100, diagonalsAllowed: false)
    let doors = [vector_int2(3, 5) : "House_Bedroom"]
    
    func start(_ from: SKScene?) -> vector_int2 {
        vector_int2(7, 4)
    }
}
