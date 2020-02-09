import Library
import GameplayKit

class WalkScene: SKScene {
    var grid: GKGridGraph<GKGridGraphNode>!
    var doors = [vector_int2 : LocationId]()
    var items = [vector_int2 : ItemId]()
    var chests = [vector_int2 : (ItemId, String)]()
    var starts = [LocationId : vector_int2]()
    var npc = [(NpcId, vector_int2)]()
    var entities = [GKEntity]()
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
        npc.enumerated().forEach {
            let npc = NpcWalk($0.1.0, tag: $0.0)
            entities.append(npc)
            npc.component(ofType: SpriteWalk.self)!.move($0.1.1)
            addChild(npc.component(ofType: SpriteWalk.self)!.node)
            nodes.append(grid.node(atGridPosition: .init(.init($0.1.1.x), .init($0.1.1.y)))!)
        }
        grid.remove(nodes)
        chests.keys.forEach {
            if memory.game.items.taken[location]?.contains($0) == true {
                unbox($0)
            }
        }
    }
    
    final func unbox(_ position: vector_int2) {
        let group = SKTileGroup(tileDefinition: .init(texture: .init(imageNamed: chests[position]!.1)))
        _items.tileSet.tileGroups.append(group)
        _items.setTileGroup(group, forColumn: .init(position.x), row: .init(position.y))
    }
}
