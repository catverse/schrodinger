import SpriteKit

final class MenuScene: SKScene {
    private weak var cat: SKSpriteNode!
    private weak var title: SKLabelNode!
    private weak var cont: SKLabelNode!
    private weak var inventory: SKLabelNode!
    private weak var save: SKLabelNode!
    private weak var exit: SKLabelNode!
    private weak var overwrite: SKLabelNode!
    private weak var new: SKLabelNode!
    private weak var cancel: SKLabelNode!
    private weak var confirm: SKLabelNode!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute]
        
        let sprite = SKSpriteNode(imageNamed: "front")
        sprite.size = .init(width: 64, height: 64)
        sprite.position.x = -95
        sprite.position.y = 40
        addChild(sprite)
        
        let title = SKLabelNode(fontNamed: SKLabelNode.font)
        title.fontColor = .haze()
        title.fontSize = 10
        title.verticalAlignmentMode = .center
        title.position.y = 130
        addChild(title)
        self.title = title
        
        let place = SKLabelNode(fontNamed: SKLabelNode.font)
        place.fontColor = .haze()
        place.fontSize = 12
        place.verticalAlignmentMode = .center
        place.horizontalAlignmentMode = .left
        place.position.x = -140
        place.position.y = -130
        place.text = .key("Location.\(memory.game.value!.location.rawValue)")
        addChild(place)
        
        let time = SKLabelNode(fontNamed: SKLabelNode.font)
        time.fontColor = .haze()
        time.fontSize = 12
        time.verticalAlignmentMode = .center
        time.horizontalAlignmentMode = .left
        time.position.x = -140
        time.position.y = -100
        time.text = formatter.string(from: memory.game.value!.time)
        addChild(time)
        
        let level = SKLabelNode(fontNamed: SKLabelNode.font)
        level.fontColor = .haze()
        level.fontSize = 12
        level.verticalAlignmentMode = .center
        level.horizontalAlignmentMode = .left
        level.position.x = -140
        level.position.y = -70
        level.text = .key("Menu.level")
        addChild(level)
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        addChild(cat)
        self.cat = cat
        
        cont = label(.key("Menu.continue"), y: 45)
        inventory = label(.key("Menu.inventory"), y: 15)
        save = label(.key("Menu.save"), y: -15)
        exit = label(.key("Menu.exit"), y: -45)
        overwrite = label(.key("Menu.overwrite"), y: 80)
        new = label(.key("Menu.new"), y: 0)
        cancel = label(.key("Menu.cancel"), y: -80)
        confirm = label(.key("Menu.confirm"), y: 0)
    }
    
    func showCont() {
        cat.position.y = cont.position.y + 2
        title.text = .key("Menu.title.menu")
        show(cont)
        fade([inventory, save, exit])
    }
    
    func showInventory() {
        cat.position.y = inventory.position.y + 2
        title.text = .key("Menu.title.menu")
        show(inventory)
        fade([cont, save, exit])
    }
    
    func showSave() {
        cat.position.y = save.position.y + 2
        title.text = .key("Menu.title.menu")
        show(save)
        fade([cont, inventory, exit])
    }
    
    func showExit() {
        cat.position.y = exit.position.y + 2
        title.text = .key("Menu.title.menu")
        show(exit)
        fade([cont, inventory, save])
    }
    
    private func label(_ text: String, y: CGFloat) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: SKLabelNode.font)
        node.alpha = 0
        node.fontColor = .white
        node.fontSize = 12
        node.verticalAlignmentMode = .center
        node.horizontalAlignmentMode = .left
        node.position.x = 30
        node.position.y = y
        node.text = text
        addChild(node)
        return node
    }
    
    private func show(_ label: SKLabelNode) {
        label.run(.fadeAlpha(to: 1, duration: 0.5))
    }
    
    private func hide(_ labels: [SKLabelNode]) {
        labels.forEach {
            $0.run(.fadeAlpha(to: 0, duration: 0.5))
        }
    }
    
    private func fade(_ labels: [SKLabelNode]) {
        labels.forEach {
            $0.run(.fadeAlpha(to: 0.4, duration: 0.5))
        }
    }
}
