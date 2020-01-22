import GameplayKit

class Stand: GKState {
    fileprivate var texture: String { "" }
    private weak var node: SKSpriteNode!
    
    init(_ node: SKSpriteNode) {
        super.init()
        self.node = node
    }
    
    override func didEnter(from: GKState?) {
        node.run(.setTexture(.init(imageNamed: texture)))
    }
}

final class Front: Stand {
    override var texture: String { "front" }
}

final class Back: Stand {
    override var texture: String { "back" }
}

final class Left: Stand {
    override var texture: String { "left" }
}

final class LeftA: Stand {
    override var texture: String { "left_walk_a" }
}

final class LeftB: Stand {
    override var texture: String { "left_walk_b" }
}

final class Right: Stand {
    override var texture: String { "right" }
}

final class RightA: Stand {
    override var texture: String { "right_walk_a" }
}

final class RightB: Stand {
    override var texture: String { "right_walk_b" }
}
