import GameplayKit

protocol Scene {
    var grid: GKGridGraph<GKGridGraphNode> { get }
}

extension Scene {
    func point(_ position: vector_int2) -> CGPoint {
        .init(x: .init(position.x) * 32, y: .init(position.y) * 32)
    }
}
