import GameplayKit

protocol Scene: SKScene {
    var grid: GKGridGraph<GKGridGraphNode> { get }
    var doors: [vector_int2 : String] { get }
    
    func start(_ from: Scene?) -> vector_int2
}
