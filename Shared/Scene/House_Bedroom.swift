import Library
import GameplayKit

final class House_Bedroom: WalkScene {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        grid = .init(fromGridStartingAt: .zero, width: 18, height: 15, diagonalsAllowed: false)
        doors = [.init(14, 3) : .House_Corridor]
        chests = [.init(7, 11) : .potion]
        starts = [.House_Corridor : .init(14, 5)]
        unboxed = "house_chest_open"
    }
}
