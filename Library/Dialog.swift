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
        let position: vector_int2
        let messages: [(Owner, [[String]])]
    }
    
    public class func prototypes(_ prototypes: [Prototype]) -> Dialog {
        let first = prototypes.first!
        return .init(first.messages.first!.0, first.messages.first!.1)
    }
    
    class func chest(_ item: ItemId?) -> Dialog {
        .init(.none, [["Dialog.Chest.Found"], item == nil
            ? ["Dialog.Chest.Empty"]
            : ["Dialog.Chest.Obtained", "Item.\(item!.rawValue)", "Dialog.Chest.Ex"]])
    }
    
    public let owner: Owner
    public let message: [[String]]
    public let next: Dialog?
    
    private init(_ owner: Owner, _ message: [[String]], _ next: Dialog? = nil) {
        self.owner = owner
        self.message = message
        self.next = next
    }
}
