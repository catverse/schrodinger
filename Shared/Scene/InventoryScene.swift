import SpriteKit

final class InventoryScene: SKScene {
    private(set) weak var cat: SKSpriteNode!
    private weak var back: SKLabelNode!
    private weak var items: SKLabelNode!
    private weak var key: SKLabelNode!
    private weak var empty: SKLabelNode!
    private weak var info: SKLabelNode!
    private weak var cancel: SKLabelNode!
    private weak var use: SKLabelNode!
    private weak var icon: SKSpriteNode!
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
        
        empty = text()
        empty.text = .key("Inventory.empty")
        
        let icon = SKSpriteNode()
        icon.alpha = 0
        addChild(icon)
        self.icon = icon
        
        info = text()
        cancel = submenu(.key("Inventory.cancel"), y: -50)
        use = submenu(.key("Inventory.use"), y: 0)
        
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
        hide([crop, empty, use, info, cancel, icon])
    }
    
    func showItems() {
        _items.forEach { $0.removeFromParent() }
        show([items, crop, cat])
        fade([back, key])
        hide([empty, use, info, cancel, icon])
    }
    
    func showItemsEmpty() {
        _items.forEach { $0.removeFromParent() }
        show([items, crop])
        fade([back, key, empty])
        hide([cat, use, info, cancel, icon])
    }
    
    func showKey() {
        _items.forEach { $0.removeFromParent() }
        show([key, crop, cat])
        fade([back, items])
        hide([empty, use, info, cancel, icon])
    }
    
    func showKeyEmpty() {
        _items.forEach { $0.removeFromParent() }
        show([key, crop])
        fade([back, items, empty])
        hide([cat, use, info, cancel, icon])
    }
    
    func showInfo() {
        show([info, cancel, icon])
        hide([crop, cat, use])
    }
    
    func showUse() {
        show([info, use, icon])
        fade([cancel])
        hide([crop, cat])
    }
    
    func showCancel() {
        show([info, cancel, icon])
        fade([use])
        hide([crop, cat])
    }
    
    func hideInfo() {
        
    }
    
    func hideUse() {
        
    }
    
    func hideCancel() {
        
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
    
    private func submenu(_ text: String, y: CGFloat) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: SKLabelNode.font)
        node.alpha = 0
        node.fontColor = .haze()
        node.fontSize = 12
        node.position.y = y
        node.text = text
        addChild(node)
        return node
    }
    
    private func text() -> SKLabelNode {
        let node = SKLabelNode(fontNamed: SKLabelNode.font)
        node.alpha = 0
        node.fontColor = .white
        node.fontSize = 12
        node.position.y = -20
        node.numberOfLines = 2
        node.verticalAlignmentMode = .center
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
