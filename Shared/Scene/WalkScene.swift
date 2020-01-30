import Library
import GameplayKit

protocol WalkScene: SKScene {
    var player: WalkPlayer! { get set }
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
    var location: Location { Location(rawValue: name!)! }
    private var _darkness: DarknessNode { childNode(withName: "Darkness") as! DarknessNode }
    private var _floor: SKTileMapNode { _darkness.childNode(withName: "Floor") as! SKTileMapNode }
    private var _items: SKTileMapNode { _darkness.childNode(withName: "Items") as! SKTileMapNode }
    
    func configure() {
        var nodes = [GKGridGraphNode]()
        (0 ..< grid.gridWidth).forEach { x in
            (0 ..< grid.gridHeight).forEach { y in
                if _floor.tileDefinition(atColumn: x, row: y) == nil || _items.tileDefinition(atColumn: x, row: y) != nil {
                    nodes.append(grid.node(atGridPosition: .init(.init(x), .init(y)))!)
                }
            }
        }
        grid.remove(nodes)
        chests.keys.forEach {
            if memory.game.value!.taken[location]?.contains($0) == true {
                unbox($0)
            }
        }
    }
    
    func unbox(_ position: vector_int2) {
        let group = SKTileGroup(tileDefinition: .init(texture: .init(imageNamed: unboxed)))
        _items.tileSet.tileGroups.append(group)
        _items.setTileGroup(group, forColumn: .init(position.x), row: .init(position.y))
    }
}
