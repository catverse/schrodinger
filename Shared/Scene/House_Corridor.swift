import GameplayKit

final class House_Corridor: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 32, height: 8, diagonalsAllowed: false)
    let doors = [vector_int2(3, 5) : "House_Bedroom"]
    let items = [:] as [vector_int2 : String]
    
    func start(_ from: SKScene?) -> vector_int2 {
        vector_int2(7, 4)
    }
    
    override func didMove(to: SKView) {
        configure()
    }
}
