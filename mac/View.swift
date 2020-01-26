import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        (state.currentState as! State).control(Direction(rawValue: with.keyCode) ?? .none, Action(rawValue: with.keyCode) ?? .none)
    }
}
