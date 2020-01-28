import GameplayKit

final class DialogState: State {
    private var dialog = [[String]]()
    private var timer = TimeInterval()
    
    override func didEnter(from: GKState?) {
        game.scene!.camera!.addChild(DialogNode(game.bounds))
        game.scene!.camera!.children.compactMap { $0 as? DialogNode }.first!.label.text = ""
        timer = 1
    }
    
    override func willExit(to: GKState) {
        game.scene!.camera!.children.first { $0 is DialogNode }!.removeFromParent()
    }
    
    override func update(deltaTime: TimeInterval) {
        super.update(deltaTime: deltaTime)
        timer -= deltaTime
        if timer <= 0 {
            timer = 1
            if !dialog.isEmpty {
                let label = game.scene!.camera!.children.compactMap { $0 as? DialogNode }.first!.label!
                if !dialog[0].isEmpty {
                    if !label.text!.isEmpty {
                        label.text! += " "
                    }
                    label.text! += dialog[0].removeFirst()
                }
            }
        }
    }
    
    override func control() {
        if action.0 != .none {
            
        }
        action.0 = .none
    }
    
    func dialog(_ message: [[String]]) {
        dialog = message.map { $0.flatMap { String.key($0).components(separatedBy: " ") } }
    }
}
