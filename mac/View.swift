import SpriteKit
import GameplayKit

final class View: SKView {
    required init?(coder: NSCoder) { nil }
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
//        if let scene = GKScene(fileNamed: "GameScene") {

            // Get the SKScene from the loaded GKScene
//            if let sceneNode = scene.rootNode as! GameScene? {
//
//                // Copy gameplay related content over to the scene
//                sceneNode.entities = scene.entities
//                sceneNode.graphs = scene.graphs
//
//                // Set the scale mode to scale to fit the window
//                sceneNode.scaleMode = .aspectFill
//
//                // Present the scene
//                presentScene(sceneNode)
//
//                ignoresSiblingOrder = true
//
//                showsFPS = true
//                showsNodeCount = true
//            }
//        }
        
        if let scene = GKScene(fileNamed: "Home") {
            if let node = scene.rootNode as? Home {
                                presentScene(node)
                
                                ignoresSiblingOrder = true
                
                                showsFPS = true
                                showsNodeCount = true
            }
        }
    }
}
