import SpriteKit

final class InventoryScene: SKScene {
    private weak var cat: SKSpriteNode!
    private weak var back: SKLabelNode!
    private weak var items: SKLabelNode!
    private weak var key: SKLabelNode!
    private weak var list: SKShapeNode!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        
        let title = SKLabelNode(fontNamed: SKLabelNode.font)
        title.fontColor = .haze()
        title.fontSize = 10
        title.verticalAlignmentMode = .center
        title.position.y = 140
        title.text = .key("Inventory.title")
        addChild(title)
        
        let list = SKShapeNode(rect: .init(origin: .init(x: -145, y: -145), size: .init(width: 290, height: 225)))
        list.alpha = 0
        list.strokeColor = .white
        list.lineWidth = 2
        addChild(list)
        self.list = list
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        list.addChild(cat)
        self.cat = cat
        
        back = menu(.key("Inventory.back"), x: -121)
        items = menu(.key("Inventory.items"), x: 0)
        key = menu(.key("Inventory.key"), x: 126)
    }
    
    func showBack() {
        list.children.filter { $0 !== cat }.forEach { $0.removeFromParent() }
        show([back])
        fade([items, key])
        hide([list])
    }
    
    func showItems() {
        list.children.filter { $0 !== cat }.forEach { $0.removeFromParent() }
        show([items, list])
        fade([back, key])
    }
    
    func showKey() {
        list.children.filter { $0 !== cat }.forEach { $0.removeFromParent() }
        show([key, list])
        fade([back, items])
    }
    
    private func menu(_ text: String, x: CGFloat) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: SKLabelNode.font)
        node.alpha = 0
        node.fontColor = .white
        node.fontSize = 12
        node.verticalAlignmentMode = .top
        node.position.x = x
        node.position.y = 120
        node.text = text
        addChild(node)
        return node
    }
    
    private func show(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 1, duration: 0.5))
        }
    }
    
    private func fade(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 0.4, duration: 0.5))
        }
    }
    
    private func hide(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 0, duration: 0.5))
        }
    }
}
