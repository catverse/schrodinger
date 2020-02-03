import Foundation

public protocol Item {
    
}

public protocol HealingItem {
    var hp: Int { get }
}

public final class ItemFactory {
    public class func make(_ id: ItemId) -> Item {
        switch id {
        case .Potion: return Potion()
        }
    }
}

private struct Potion: Item, HealingItem {
    let hp = 20
}
