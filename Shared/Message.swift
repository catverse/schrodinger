import SpriteKit

final class Message: SKNode {
    private weak var title: SKSpriteNode!
    private weak var text: SKSpriteNode!
    private weak var label: SKLabelNode!
    private weak var left: SKLabelNode!
    private weak var right: SKLabelNode!
    
    required init?(coder aDecoder: NSCoder) { nil }
    override init() {
        super.init()
        isHidden = true
        zPosition = 100
        
        let text = SKSpriteNode(imageNamed: "dialog_text")
        text.zPosition = 0
        addChild(text)
        self.text = text
        
        let title = SKSpriteNode(imageNamed: "dialog_title")
        title.zPosition = 1
        title.isHidden = true
        addChild(title)
        self.title = title
        
        let label = SKLabelNode(fontNamed: "PressStart2P-Regular")
        label.zPosition = 2
        label.fontColor = .white
        label.fontSize = 16
        label.verticalAlignmentMode = .center
        label.numberOfLines = 3
        label.horizontalAlignmentMode = .left
        label.isHidden = true
        addChild(label)
        self.label = label
        
        let left = SKLabelNode(fontNamed: "PressStart2P-Regular")
        left.zPosition = 3
        left.fontColor = .black
        left.fontSize = 16
        left.horizontalAlignmentMode = .left
        left.isHidden = true
        addChild(left)
        self.left = left
        
        let right = SKLabelNode(fontNamed: "PressStart2P-Regular")
        right.zPosition = 3
        right.fontColor = .black
        right.fontSize = 16
        right.horizontalAlignmentMode = .right
        right.isHidden = true
        addChild(right)
        self.right = right
    }
    
    func bound(_ bounds: CGRect) {
        text.position.y = (bounds.height - 100) / -2
        title.position.y = text.position.y + 73
        label.position.y = text.position.y
        label.position.x = (bounds.width - 50) / -2
        left.position.y = title.position.y - 10
        left.position.x = label.position.x
        right.position.y = left.position.y
        right.position.x = -label.position.x
        text.size.width = bounds.width
        title.size.width = bounds.width
    }
}
