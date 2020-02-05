import Foundation

public protocol Item {
    
}

public protocol KeyItem {
    
}

public protocol BattleItem {
    
}

public protocol WalkingItem {
    
}

public protocol HealingItem {
    var hp: Int { get }
}

public final class ItemFactory {
    public class func make(_ id: ItemId) -> Item {
        switch id {
        case .potion: return Potion()
        }
    }
}

private struct Potion: Item, BattleItem, WalkingItem, HealingItem {
    let hp = 20
}
