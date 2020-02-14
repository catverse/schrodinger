import Library
import GameplayKit

final class DialogState: State {
    var dialog: Dialog?
    var finish: State.Type!
    private weak var node: DialogNode!
    private var message = [[String]]()
    private var timer = TimeInterval()
    private let wait = TimeInterval(0.2)
    
    override func didEnter(from: GKState?) {
        super.didEnter(from: from)
        node?.removeFromParent()
        let node = DialogNode(game.bounds)
        game.scene!.camera!.addChild(node)
        self.node = node
        
        timer = wait + wait
        next()
    }
    
    override func willExit(to: GKState) {
        super.willExit(to: to)
        node.run(.sequence([.fadeOut(withDuration: 0.4), .removeFromParent()]))
    }
    
    override func update(deltaTime: TimeInterval) {
        super.update(deltaTime: deltaTime)
        timer -= deltaTime
        if timer <= 0 {
            timer = wait
            if !message.isEmpty && !message[0].isEmpty {
                write()
            }
        }
    }
    
    override func control() {
        super.control()
        if action.0 != .none {
            timer = wait
            if !message.isEmpty {
                if message[0].isEmpty {
                    message.removeFirst()
                    if message.isEmpty {
                        if dialog == nil {
                            stateMachine!.enter(finish)
                        } else {
                            node.label!.text = ""
                            next()
                        }
                    } else {
                        node.label!.text = ""
                    }
                } else {
                    while !message[0].isEmpty {
                        write()
                    }
                }
            }
        }
        action.0 = .none
    }
    
    private func next() {
        message = dialog!.message.map { $0.flatMap { String.key($0).components(separatedBy: " ") } }
        switch dialog!.owner {
        case .none:
            node.title.isHidden = true
            node.left.text = ""
            node.right.text = ""
        case .player:
            node.title.isHidden = false
            node.left.text = .key("Player.name")
            node.right.text = ""
        case .npc(let id):
            node.title.isHidden = false
            node.left.text = ""
            node.right.text = .key("Npc.\(id.rawValue)")
        }
        dialog = dialog!.next
    }
    
    private func write() {
        if !node.label.text!.isEmpty {
            node.label.text! += " "
        }
        node.label.text! += message[0].removeFirst()
    }
}
