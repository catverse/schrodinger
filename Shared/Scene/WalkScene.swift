import Library
import GameplayKit

class WalkScene: SKScene {
    var player: WalkPlayer!
    var grid: GKGridGraph<GKGridGraphNode>!
    var doors = [vector_int2 : LocationId]()
    var items = [vector_int2 : ItemId]()
    var chests = [vector_int2 : ItemId]()
    var starts = [LocationId : vector_int2]()
    var unboxed = ""
    final var location: LocationId { LocationId(rawValue: name!)! }
    private var _darkness: DarknessNode { childNode(withName: "Darkness") as! DarknessNode }
    private var _floor: SKTileMapNode { _darkness.childNode(withName: "Floor") as! SKTileMapNode }
    private var _items: SKTileMapNode { _darkness.childNode(withName: "Items") as! SKTileMapNode }
     
    final override func didMove(to: SKView) {
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
            if memory.game.items.taken[location]?.contains($0) == true {
                unbox($0)
            }
        }
    }
    
    final func unbox(_ position: vector_int2) {
        let group = SKTileGroup(tileDefinition: .init(texture: .init(imageNamed: unboxed)))
        _items.tileSet.tileGroups.append(group)
        _items.setTileGroup(group, forColumn: .init(position.x), row: .init(position.y))
    }
}
