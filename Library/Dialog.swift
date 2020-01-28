import Foundation

final class Dialog {
    class func chest(_ item: Item?) -> [[String]] {
        [["Dialog.Chest.Found"], item == nil ? ["Dialog.Chest.Empty"] : ["Dialog.Chest.Obtained", "Item.\(item!.rawValue)"]]
    }
}
