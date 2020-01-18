import SpriteKit
import GameplayKit

final class Window: NSWindow {
    init() {
        super.init(contentRect: .init(x: 0, y: 0, width: 900, height: 638), styleMask: [.borderless, .miniaturizable, .resizable, .closable, .titled, .unifiedTitleAndToolbar, .fullSizeContentView], backing: .buffered, defer: false)
        center()
        minSize = .init(width: 900, height: 638)
        appearance = NSAppearance(named: .darkAqua)
        backgroundColor = .black
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        toolbar = .init()
        toolbar!.showsBaselineSeparator = false
        isOpaque = true
        collectionBehavior = .fullScreenNone
        isReleasedWhenClosed = false
        isMovableByWindowBackground = false
        
        let view = SKView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.presentScene(GKScene(fileNamed: "Home")!.rootNode as? SKScene)
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
        contentView!.addSubview(view)
        
        view.centerYAnchor.constraint(equalTo: contentView!.centerYAnchor, constant: 24).isActive = true
        view.centerXAnchor.constraint(equalTo: contentView!.centerXAnchor).isActive = true
        view.widthAnchor.constraint(equalToConstant: 900).isActive = true
        view.heightAnchor.constraint(equalToConstant: 600).isActive = true
    }
    
    override func close() {
        NSApp.terminate(nil)
    }
}
