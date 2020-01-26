import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        if let direction = Direction(rawValue: with.keyCode) {
            (state.currentState as! State).direction = direction
        } else if let action = Action(rawValue: with.keyCode) {
            (state.currentState as! State).action = action
        }
    }
    
    override func keyUp(with: NSEvent) {
        if (state.currentState as! State).direction.rawValue == with.keyCode {
            (state.currentState as! State).direction = .none
        } else if (state.currentState as! State).action.rawValue == with.keyCode {
            (state.currentState as! State).action = .none
        }
    }
    
    override func viewDidEndLiveResize() {
        message.bound(bounds)
    }
}
