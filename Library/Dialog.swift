import Foundation
import simd

public final class Dialog {
    public enum Owner {
        case
        none,
        player,
        npc(id: NpcId)
    }
    
    public struct Proto {
        let step: Int
        let position: vector_int2
        let messages: [(NpcId, [[String]])]
    }
    
    public class func npc(_ id: NpcId) {
        
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
