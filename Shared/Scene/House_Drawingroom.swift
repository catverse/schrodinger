import Library
import GameplayKit

final class House_Drawingroom: WalkScene {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        grid = .init(fromGridStartingAt: .zero, width: 40, height: 32, diagonalsAllowed: false)
        doors = [.init(21, 30) : .House_Corridor]
        starts = [.House_Corridor : .init(21, 28)]
    }
}