import Foundation
import simd

public final class Dialog {
    public enum Owner: Equatable {
        case
        none,
        player,
        npc(id: NpcId)
    }
    
    public struct Message {
        public let owner: Owner
        public let messages: [[String]]
        
        public init(_ owner: Owner, _ messages: [[String]]) {
            self.owner = owner
            self.messages = messages
        }
    }
    
    public struct Npc {
        let messages: [Message]
        
        public init(_ messages: [Message]) {
            self.messages = messages
        }
    }
    
    public class func npc(_ npc: [[Npc]]) -> [[Dialog]] {
        npc.map {
            $0.map {
                var messages = $0.messages
                var dialog: Dialog?
                while let message = messages.popLast() {
                    dialog = .init(message, dialog)
                }
                return dialog!
            }
        }
    }
    
    class func chest(_ item: ItemId?) -> Dialog {
        .init(.init(.none, [["Dialog.Chest.Found"], item == nil
            ? ["Dialog.Chest.Empty"]
            : ["Dialog.Chest.Obtained", "Item.\(item!.rawValue)", "Dialog.Chest.Ex"]]), nil)
    }
    
    public let message: Message
    public let next: Dialog?
    
    private init(_ message: Message, _ next: Dialog?) {
        self.message = message
        self.next = next
    }
}
