import Library
import GameplayKit

protocol Scene: SKScene {
    var grid: GKGridGraph<GKGridGraphNode> { get }
    var doors: [vector_int2 : Location] { get }
    var items: [vector_int2 : Item] { get }
    var chests: [vector_int2 : Item] { get }
    
    func start(_ from: SKScene?) -> vector_int2
}

extension Scene {
    var doors: [vector_int2 : Location] { [:] }
    var items: [vector_int2 : Item] { [:] }
    var chests: [vector_int2 : Item] { [:] }
    
    func configure() {
        let floor = childNode(withName: "Floor") as! SKTileMapNode
        let items = childNode(withName: "Items") as! SKTileMapNode
        var nodes = [GKGridGraphNode]()
        (0 ..< grid.gridWidth).forEach { x in
            (0 ..< grid.gridHeight).forEach { y in
                if floor.tileDefinition(atColumn: x, row: y) == nil || items.tileDefinition(atColumn: x, row: y) != nil {
                    nodes.append(grid.node(atGridPosition: .init(.init(x), .init(y)))!)
                }
            }
        }
        grid.remove(nodes)
    }
}
