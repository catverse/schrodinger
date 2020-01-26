import SpriteKit

final class Message: SKNode {
    private weak var title: SKSpriteNode!
    private weak var text: SKSpriteNode!
    
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
        addChild(title)
        self.title = title
    }
    
    func bound(_ bounds: CGRect) {
        text.position.y = (bounds.height - 65) / -2
        title.position.y = text.position.y + 49
        text.size.width = bounds.width
        title.size.width = bounds.width
    }
}
