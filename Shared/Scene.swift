import GameplayKit

protocol Scene {
    var grid: GKGridGraph<GKGridGraphNode> { get }
    
    func start(_ from: Scene?) -> vector_int2
}
