import Library
import GameplayKit

protocol WalkScene: SKScene {
    var grid: GKGridGraph<GKGridGraphNode> { get }
    var doors: [vector_int2 : Location] { get }
    var items: [vector_int2 : Item] { get }
    var chests: [vector_int2 : Item] { get }
    var unboxed: String { get }
    
    func start(_ from: SKScene?) -> vector_int2
}

extension WalkScene {
    var doors: [vector_int2 : Location] { [:] }
    var items: [vector_int2 : Item] { [:] }
    var chests: [vector_int2 : Item] { [:] }
    var unboxed: String { "" }
    
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
        chests.keys.forEach {
            if memory.game.value!.taken[Location(rawValue: name!)!]?.contains($0) == true {
                unbox($0)
            }
        }
    }
    
    func unbox(_ position: vector_int2) {
        let group = SKTileGroup(tileDefinition: .init(texture: .init(imageNamed: unboxed)))
        (childNode(withName: "Items") as! SKTileMapNode).tileSet.tileGroups.append(group)
        (childNode(withName: "Items") as! SKTileMapNode).setTileGroup(group, forColumn: .init(position.x), row: .init(position.y))
    }
}
