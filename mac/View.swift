import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        (state.currentState as! State).direction(Direction(rawValue: with.keyCode) ?? .none)
        (state.currentState as! State).action(Action(rawValue: with.keyCode) ?? .none)
    }
}
