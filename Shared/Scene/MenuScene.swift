import SpriteKit

final class MenuScene: SKScene {
    private weak var cat: SKSpriteNode!
    
    required init?(coder: NSCoder) { nil }
    override init() {
        super.init(size: .init(width: 300, height: 300))
        backgroundColor = .black
        anchorPoint = .init(x: 0.5, y: 0.5)
        scaleMode = .resizeFill
        
        let cat = SKSpriteNode(imageNamed: "menu_cat")
        cat.position.x = 50
        addChild(cat)
        self.cat = cat
        
        let cont = SKLabelNode(fontNamed: SKLabelNode.font)
        cont.fontColor = .white
        cont.fontSize = 12
        cont.text = .key("Menu.continue")
        cont.verticalAlignmentMode = .center
        cont.horizontalAlignmentMode = .left
        cont.position.y = 140
        cont.position.x = 100
        addChild(cont)
    }
}
