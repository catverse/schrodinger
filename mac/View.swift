import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        if let direction = Direction(rawValue: with.keyCode) {
            (state.currentState as! State).direction = (direction, direction)
        } else if let action = Action(rawValue: with.keyCode) {
            (state.currentState as! State).action = (action, action)
        }
    }
    
    override func keyUp(with: NSEvent) {
        if (state.currentState as! State).direction.0.rawValue == with.keyCode {
            (state.currentState as! State).direction.1 = .none
        } else if (state.currentState as! State).action.0.rawValue == with.keyCode {
            (state.currentState as! State).action.1 = .none
        }
    }
    
    override func viewDidEndLiveResize() {
        scene!.camera!.children.compactMap { $0 as? DialogNode }.first?.bound(bounds)
    }
}
