import Foundation
import simd

public final class Dialog {
    public enum Owner: Equatable {
        case
        none,
        player,
        npc(id: NpcId)
    }
    
    public struct Prototype {
        let step: Int
        let messages: [(Owner, [[String]])]
        let increases: Bool
        
        public init(_ messages: [(Owner, [[String]])], step: Int, increases: Bool = false) {
            self.messages = messages
            self.step = step
            self.increases = increases
        }
    }
    
    public class func prototypes(_ prototypes: [[Prototype]]) -> [[Dialog]] {
        prototypes.map { $0.sorted { $0.step < $1.step } }.map {
            var messages = $0.messages
            var dialog: Dialog?
            while let message = messages.popLast() {
                dialog = .init(message.0, message.1, dialog)
            }
            return dialog!
        }
    }
    
    class func chest(_ item: ItemId?) -> Dialog {
        .init(.none, [["Dialog.Chest.Found"], item == nil
            ? ["Dialog.Chest.Empty"]
            : ["Dialog.Chest.Obtained", "Item.\(item!.rawValue)", "Dialog.Chest.Ex"]], nil)
    }
    
    public let owner: Owner
    public let message: [[String]]
    public let next: Dialog?
    
    private init(_ owner: Owner, _ message: [[String]], _ next: Dialog?) {
        self.owner = owner
        self.message = message
        self.next = next
    }
}
