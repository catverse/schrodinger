import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        (state.currentState as! State).direction(Key(rawValue: with.keyCode) ?? .none)
    }
}
