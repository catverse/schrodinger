import GameplayKit

final class SkinComponent: GKComponent {
    var name: String
    
    required init?(coder: NSCoder) { nil }
    init(_ name: String) {
        self.name = name
        super.init()
    }
}
