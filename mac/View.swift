import AppKit

final class View: Game {
    override func keyDown(with: NSEvent) {
        player.component(ofType: Control.self)!.direction = Key(rawValue: with.keyCode) ?? .none
    }
}
