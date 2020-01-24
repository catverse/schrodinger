import GameplayKit

final class House_Bedroom: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 100, height: 100, diagonalsAllowed: false)
    let doors = [vector_int2(5, 3) : "House_Corridor"]
    
    func start(_ from: Scene?) -> vector_int2 {
        vector_int2(1, 3)
    }
}
