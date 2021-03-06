import Library
import SpriteKit

final class StartScene: SKScene {
    private weak var cat: SKSpriteNode!
    private weak var press: SKLabelNode!
    private weak var new: SKLabelNode!
    private weak var cont: SKLabelNode!
    private weak var back: SKLabelNode!
    private weak var list: SKNode!
    private let blink = SKAction.repeatForever(.sequence([.fadeIn(withDuration: 0.5), .wait(forDuration: 1), .fadeOut(withDuration: 0.5)]))
    private let formatter = DateComponentsFormatter()
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.day, .hour, .minute]
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        cat.alpha = 0
        cat.position.x = -100
        addChild(cat)
        self.cat = cat
        
        let press = SKLabelNode(fontNamed: SKLabelNode.font)
        press.alpha = 0
        press.fontColor = .init(white: 1, alpha: 0.7)
        press.fontSize = 16
        press.text = .key("Start.press")
        press.verticalAlignmentMode = .center
        addChild(press)
        self.press = press
        
        let new = SKLabelNode(fontNamed: SKLabelNode.font)
        new.alpha = 0
        new.fontSize = 16
        new.text = .key("Start.new")
        new.verticalAlignmentMode = .center
        new.position.y = -90
        addChild(new)
        self.new = new
        
        let cont = SKLabelNode(fontNamed: SKLabelNode.font)
        cont.alpha = 0
        cont.fontSize = 16
        cont.text = .key("Start.continue")
        cont.verticalAlignmentMode = .center
        cont.position.y = -120
        addChild(cont)
        self.cont = cont
        
        let list = SKNode()
        list.alpha = 0
        addChild(list)
        self.list = list
        
        let back = SKLabelNode(fontNamed: SKLabelNode.font)
        back.fontColor = .init(white: 1, alpha: 0.7)
        back.fontSize = 16
        back.text = .key("Start.back")
        back.verticalAlignmentMode = .center
        list.addChild(back)
        self.back = back
    }
    
    func showPress() {
        remove()
        
        press.run(blink)
        new.run(.fadeOut(withDuration: 0.5))
        cont.run(.fadeOut(withDuration: 0.5))
        list.run(.fadeOut(withDuration: 0.5))
        cat.run(.fadeOut(withDuration: 0.5))
    }
    
    func showNew() {
        remove()
        
        new.fontColor = .white
        cont.fontColor = .init(white: 1, alpha: 0.5)
        cat.position.y = new.position.y + 2
        new.run(blink)
        press.run(.fadeOut(withDuration: 0.5))
        cont.run(.fadeIn(withDuration: 0.5))
        list.run(.fadeOut(withDuration: 0.5))
        cat.run(.fadeIn(withDuration: 0.5))
    }
    
    func showCont() {
        remove()
        
        new.fontColor = .init(white: 1, alpha: 0.5)
        cont.fontColor = .white
        cat.position.y = cont.position.y + 2
        cont.run(blink)
        press.run(.fadeOut(withDuration: 0.5))
        new.run(.fadeIn(withDuration: 0.5))
        list.run(.fadeOut(withDuration: 0.5))
        cat.run(.fadeIn(withDuration: 0.5))
    }
    
    func showList() {
        remove()
        
        list.position.y = 0
        cat.position.y = 2
        press.run(.fadeOut(withDuration: 0.5))
        new.run(.fadeOut(withDuration: 0.5))
        cont.run(.fadeOut(withDuration: 0.5))
        list.run(.fadeIn(withDuration: 0.5))
        cat.run(.fadeIn(withDuration: 0.5))
    }
    
    func list(_ entries: [Entry]) {
        if entries.isEmpty {
            let empty = SKLabelNode(fontNamed: SKLabelNode.font)
            empty.fontColor = .init(white: 1, alpha: 0.5)
            empty.fontSize = 16
            empty.text = .key("Start.empty")
            empty.verticalAlignmentMode = .center
            empty.position.y = -50
            list.addChild(empty)
        } else {
            entries.enumerated().forEach {
                let location = SKLabelNode(fontNamed: SKLabelNode.font)
                location.fontColor = .white
                location.fontSize = 12
                location.text = .key("Location.\($0.1.location.id.rawValue)")
                location.verticalAlignmentMode = .center
                location.horizontalAlignmentMode = .left
                location.position = .init(x: -45, y: ($0.0 * -80) - 70)
                list.addChild(location)
                
                let time = SKLabelNode(fontNamed: SKLabelNode.font)
                time.fontColor = .white
                time.fontSize = 12
                time.text = formatter.string(from: $0.1.time.played)
                time.verticalAlignmentMode = .center
                time.horizontalAlignmentMode = .left
                time.position = .init(x: -45, y: ($0.0 * -80) - 90)
                list.addChild(time)
            }
        }
    }
    
    func scrollDown() {
        list.run(.moveBy(x: 0, y: 80, duration: 0.35))
    }
    
    func scrollUp() {
        list.run(.moveBy(x: 0, y: -80, duration: 0.35))
    }
    
    private func remove() {
        list.children.filter { $0 !== back }.forEach { $0.removeFromParent() }
        press.removeAllActions()
        cont.removeAllActions()
        new.removeAllActions()
        list.removeAllActions()
    }
}
