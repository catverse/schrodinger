import Library
import GameplayKit

final class DialogState: State {
    var dialog: Dialog?
    private var message = [[String]]()
    private var timer = TimeInterval()
    private let wait = TimeInterval(0.3)
    
    override func didEnter(from: GKState?) {
        game.scene!.camera!.addChild(DialogNode(game.bounds))
        game.scene!.camera!.children.compactMap { $0 as? DialogNode }.first!.label.text = ""
        timer = wait
    }
    
    override func willExit(to: GKState) {
        game.scene!.camera!.children.first { $0 is DialogNode }!.removeFromParent()
    }
    
    override func update(deltaTime: TimeInterval) {
        super.update(deltaTime: deltaTime)
        timer -= deltaTime
        if timer <= 0 {
            timer = wait
            if !message.isEmpty && !message[0].isEmpty {
                write()
            } else {
                next()
            }
        }
    }
    
    override func control() {
        if action.0 != .none {
            timer = wait
            if message.isEmpty {
                next()
            } else {
                if message[0].isEmpty {
                    game.scene!.camera!.children.compactMap { $0 as? DialogNode }.first!.label!.text = ""
                    message.removeFirst()
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
        if dialog != nil {
            message = dialog!.message.map { $0.flatMap { String.key($0).components(separatedBy: " ") } }
            dialog = dialog!.next
        }
    }
    
    private func write() {
        let label = game.scene!.camera!.children.compactMap { $0 as? DialogNode }.first!.label!
        if !label.text!.isEmpty {
            label.text! += " "
        }
        label.text! += message[0].removeFirst()
    }
}
