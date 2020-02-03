import SpriteKit

final class InventoryScene: SKScene {
    private(set) weak var cat: SKSpriteNode!
    private weak var back: SKLabelNode!
    private weak var items: SKLabelNode!
    private weak var key: SKLabelNode!
    private weak var empty: SKLabelNode!
    private weak var list: SKNode!
    private weak var crop: SKCropNode!
    private var _items: [SKNode] { list.children.filter { $0 !== cat } }
    
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
        
        let crop = SKCropNode()
        crop.alpha = 0
        addChild(crop)
        self.crop = crop
        
        let mask = SKShapeNode(rect: .init(origin: .init(x: -145, y: -145), size: .init(width: 290, height: 225)))
        mask.fillColor = .white
        crop.maskNode = mask
        
        let square = SKShapeNode(rect: .init(origin: .init(x: -145, y: -145), size: .init(width: 290, height: 225)))
        square.strokeColor = .white
        square.lineWidth = 3
        crop.addChild(square)
        
        let list = SKNode()
        crop.addChild(list)
        self.list = list
        
        let empty = SKLabelNode(fontNamed: SKLabelNode.font)
        empty.alpha = 0
        empty.fontColor = .white
        empty.fontSize = 12
        empty.position.y = -20
        empty.verticalAlignmentMode = .center
        empty.text = .key("Inventory.empty")
        addChild(empty)
        self.empty = empty
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        cat.alpha = 0
        cat.position.x = -110
        list.addChild(cat)
        self.cat = cat
        
        back = menu(.key("Inventory.back"), x: -121)
        items = menu(.key("Inventory.items"), x: 0)
        key = menu(.key("Inventory.key"), x: 126)
    }
    
    func showBack() {
        _items.forEach { $0.removeFromParent() }
        show([back])
        fade([items, key])
        hide([crop, empty])
    }
    
    func showItems() {
        _items.forEach { $0.removeFromParent() }
        show([items, crop, cat])
        fade([back, key])
        hide([empty])
    }
    
    func showItemsEmpty() {
        _items.forEach { $0.removeFromParent() }
        show([items, crop])
        fade([back, key, empty])
        hide([cat])
    }
    
    func showKey() {
        _items.forEach { $0.removeFromParent() }
        show([key, crop, cat])
        fade([back, items])
        hide([empty])
    }
    
    func showKeyEmpty() {
        _items.forEach { $0.removeFromParent() }
        show([key, crop])
        fade([back, items, empty])
        hide([cat])
    }
    
    func list(_ items: [String]) {
        items.enumerated().forEach {
            let node = SKLabelNode(fontNamed: SKLabelNode.font)
            node.fontColor = .white
            node.fontSize = 12
            node.verticalAlignmentMode = .top
            node.horizontalAlignmentMode = .left
            node.position.x = -70
            node.position.y = 50 - (.init($0.0) * 45)
            node.text = $0.1
            list.addChild(node)
        }
        cat(0)
    }
    
    func cat(_ index: Int) {
        cat.position.y = 50 - (.init(index) * 45)
    }
    
    func scrollUp() {
        list.run(.moveBy(x: 0, y: -180, duration: 0.5))
    }
    
    func scrollDown() {
        list.run(.moveBy(x: 0, y: 180, duration: 0.5))
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
