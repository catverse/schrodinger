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
    private weak var saved: SKLabelNode!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        cat.alpha = 0
        addChild(cat)
        self.cat = cat
        
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
        title.position.y = 140
        addChild(title)
        self.title = title
        
        info(.key("Menu.level"), y: -80)
        info(formatter.string(from: memory.game.time)!, y: -100)
        info(.key("Location.\(memory.game.location.rawValue)"), y: -130)
        
        cont = label(.key("Menu.continue"), y: 45)
        inventory = label(.key("Menu.inventory"), y: 15)
        save = label(.key("Menu.save"), y: -15)
        exit = label(.key("Menu.exit"), y: -45)
        overwrite = label(.key("Menu.overwrite"), y: 30)
        new = label(.key("Menu.new"), y: 0)
        cancel = label(.key("Menu.cancel"), y: -30)
        confirm = label(.key("Menu.confirm"), y: 0)
        saved = label(.key("Menu.saved"), y: 0)
    }
    
    func showCont() {
        cat.position.y = cont.position.y + 2
        title.text = .key("Menu.title.menu")
        show([cont, cat])
        fade([inventory, save, exit])
        hide([overwrite, new, cancel, confirm, saved])
    }
    
    func showInventory() {
        cat.position.y = inventory.position.y + 2
        title.text = .key("Menu.title.menu")
        show([inventory, cat])
        fade([cont, save, exit])
        hide([overwrite, new, cancel, confirm, saved])
    }
    
    func showSave() {
        cat.position.y = save.position.y + 2
        title.text = .key("Menu.title.menu")
        show([save, cat])
        fade([cont, inventory, exit])
        hide([overwrite, new, cancel, confirm, saved])
    }
    
    func showExit() {
        cat.position.y = exit.position.y + 2
        title.text = .key("Menu.title.menu")
        show([exit, cat])
        fade([cont, inventory, save])
        hide([overwrite, new, cancel, confirm, saved])
    }
    
    func showOverwrite() {
        cat.position.y = overwrite.position.y + 2
        title.text = .key("Menu.title.save")
        show([overwrite, cat])
        fade([new, cancel])
        hide([save, cont, inventory, exit, confirm, saved])
    }
    
    func showNew() {
        cat.position.y = new.position.y + 2
        title.text = .key("Menu.title.save")
        show([new, cat])
        fade([overwrite, cancel])
        hide([save, cont, inventory, exit, confirm, saved])
    }
    
    func showCancelSave() {
        cat.position.y = cancel.position.y + 2
        title.text = .key("Menu.title.save")
        show([cancel, cat])
        fade([overwrite, new])
        hide([save, cont, inventory, exit, confirm, saved])
    }
    
    func showSaved() {
        cat.position.y = saved.position.y + 2
        title.text = .key("Menu.title.save")
        show([saved, cat])
        hide([save, cont, inventory, exit, confirm, cancel, overwrite, new])
    }
    
    func showCancelExit() {
        cat.position.y = cancel.position.y + 2
        title.text = .key("Menu.title.exit")
        show([cancel, cat])
        fade([confirm])
        hide([save, cont, inventory, exit, overwrite, new, saved])
    }
    
    func showConfirm() {
        cat.position.y = confirm.position.y + 2
        title.text = .key("Menu.title.exit")
        show([confirm, cat])
        fade([cancel])
        hide([save, cont, inventory, exit, overwrite, new, saved])
    }
    
    private func info(_ text: String, y: CGFloat) {
        let node = SKLabelNode(fontNamed: SKLabelNode.font)
        node.fontColor = .haze()
        node.fontSize = 12
        node.verticalAlignmentMode = .center
        node.horizontalAlignmentMode = .left
        node.position.x = -140
        node.position.y = y
        node.text = text
        addChild(node)
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
    
    private func show(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 1, duration: 0.5))
        }
    }
    
    private func hide(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 0, duration: 0.5))
        }
    }
    
    private func fade(_ nodes: [SKNode]) {
        nodes.forEach {
            $0.run(.fadeAlpha(to: 0.4, duration: 0.5))
        }
    }
}
