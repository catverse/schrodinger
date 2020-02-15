import Library
import GameplayKit

final class House_Drawingroom: WalkScene {
    private let dialogs: [[Dialog]]
    
    required init?(coder: NSCoder) {
        dialogs = Dialog.npc([
            [
                .init([.init(.npc(id: .jung), [["Dialog.Drawingroom.0.0"]]),
                       .init(.player, [["Dialog.Drawingroom.0.1"]]),
                       .init(.npc(id: .jung), [["Dialog.Drawingroom.0.2"], ["Dialog.Drawingroom.0.3"]])]),
                .init([.init(.npc(id: .jung), [["Dialog.Drawingroom.1.0"]])])
            ]
        ])
        
        super.init(coder: coder)
        grid = .init(fromGridStartingAt: .zero, width: 40, height: 32, diagonalsAllowed: false)
        doors = [.init(21, 30) : .House_Corridor]
        starts = [.House_Corridor : .init(21, 28)]
        npc = [(.jung, .init(21, 20))]
    }
    
    override func dialog(_ tag: Int) -> Dialog? {
        if memory.game.log[location] == nil {
            memory.game.log[location] = [:]
        }
        if memory.game.log[location]![tag] == nil {
           memory.game.log[location]![tag] = 0
        }
        
        switch tag {
        case 0:
            let next = memory.game.log[location]![0]!
            if next == 0 {
                memory.game.log[location]![0] = 1
            }
            return dialogs[0][next]
        default: return nil
        }
    }
}
