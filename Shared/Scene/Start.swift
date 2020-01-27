import GameplayKit

final class Start: SKScene {
    private weak var cat: SKSpriteNode!
    private weak var press: SKLabelNode!
    private weak var new: SKLabelNode!
    private weak var cont: SKLabelNode!
    private let blink = SKAction.repeatForever(.sequence([.fadeIn(withDuration: 0.5), .wait(forDuration: 1), .fadeOut(withDuration: 0.5)]))
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 100, height: 100))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        
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
        new.position.y = -100
        addChild(new)
        self.new = new
        
        let cont = SKLabelNode(fontNamed: SKLabelNode.font)
        cont.alpha = 0
        cont.fontSize = 16
        cont.text = .key("Start.continue")
        cont.verticalAlignmentMode = .center
        cont.position.y = -150
        addChild(cont)
        self.cont = cont
    }
    
    func showPress() {
        remove()
        
        press.run(blink)
        new.run(.fadeOut(withDuration: 0.5))
        cont.run(.fadeOut(withDuration: 0.5))
        cat.run(.fadeOut(withDuration: 0.5))
    }
    
    func showNew() {
        remove()
        
        new.fontColor = .white
        cont.fontColor = .init(white: 1, alpha: 0.5)
        cat.position.y = new.position.y + 3
        new.run(blink)
        press.run(.fadeOut(withDuration: 0.5))
        cont.run(.fadeIn(withDuration: 0.5))
        cat.run(.fadeIn(withDuration: 0.5))
    }
    
    func showCont() {
        remove()
        
        new.fontColor = .init(white: 1, alpha: 0.5)
        cont.fontColor = .white
        cat.position.y = cont.position.y + 3
        cont.run(blink)
        press.run(.fadeOut(withDuration: 0.5))
        new.run(.fadeIn(withDuration: 0.5))
        cat.run(.fadeIn(withDuration: 0.5))
    }
    
    private func remove() {
        press.removeAllActions()
        cont.removeAllActions()
        new.removeAllActions()
    }
}
