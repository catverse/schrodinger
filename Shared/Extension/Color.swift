#if os(macOS)
import AppKit

extension NSColor {
    static func haze(_ alpha: CGFloat = 1) -> NSColor {
        alpha == 1 ? NSColor(named: "haze")! : NSColor(named: "haze")!.withAlphaComponent(alpha)
    }
    
    static func shade(_ alpha: CGFloat = 1) -> NSColor {
        alpha == 1 ? NSColor(named: "shade")! : NSColor(named: "shade")!.withAlphaComponent(alpha)
    }
}

extension CGColor {
    static func haze(_ alpha: CGFloat = 1) -> CGColor {
        NSColor.haze(alpha).cgColor
    }
    
    static func shade(_ alpha: CGFloat = 1) -> CGColor {
        NSColor.shade(alpha).cgColor
    }
}
#endif
#if os(iOS)
import UIKit

extension UIColor {
    static func haze(_ alpha: CGFloat = 1) -> UIColor {
        alpha == 1 ? UIColor(named: "haze")! : UIColor(named: "haze")!.withAlphaComponent(alpha)
    }
    
    static func shade(_ alpha: CGFloat = 1) -> UIColor {
        alpha == 1 ? UIColor(named: "shade")! : UIColor(named: "shade")!.withAlphaComponent(alpha)
    }
}

extension CGColor {
    static func haze(_ alpha: CGFloat = 1) -> CGColor {
        UIColor.haze(alpha).cgColor
    }
    
    static func shade(_ alpha: CGFloat = 1) -> CGColor {
        UIColor.shade(alpha).cgColor
    }
}
#endif
