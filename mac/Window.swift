import AppKit

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
        
        let view = View()
        contentView!.addSubview(view)
        
        view.topAnchor.constraint(equalTo: contentView!.topAnchor, constant: 38).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView!.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: contentView!.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: contentView!.rightAnchor).isActive = true
    }
    
    override func close() {
        NSApp.terminate(nil)
    }
}
