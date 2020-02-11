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
        var messages = prototypes.first!.messages
        var dialog: Dialog?
        while let message = messages.popLast() {
            dialog = .init(message.0, message.1, dialog)
        }
        return dialog!
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
