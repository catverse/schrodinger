import GameplayKit

final class House_Bedroom: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 100, height: 100, diagonalsAllowed: false)
    
    func start(_ from: Scene?) -> vector_int2 {
        vector_int2(1, 3)
    }
}
