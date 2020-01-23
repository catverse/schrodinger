import GameplayKit

final class Home: SKScene, Scene {
    let grid = GKGridGraph(fromGridStartingAt: .zero, width: 100, height: 100, diagonalsAllowed: false)
    
    override func sceneDidLoad() {
        
    }
}
