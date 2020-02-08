import Library
import GameplayKit

final class House_Corridor: WalkScene {    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        grid = .init(fromGridStartingAt: .zero, width: 32, height: 8, diagonalsAllowed: false)
        doors = [.init(3, 6) : .House_Bedroom,
                 .init(15, 1) : .House_Drawingroom]
        starts = [.House_Bedroom : .init(3, 4),
                  .House_Drawingroom : .init(15, 3)]
    }
}
