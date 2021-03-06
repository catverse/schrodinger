@testable import Library
import XCTest

final class TestDialog: XCTestCase {
    private var memory: Memory!
    
    override func setUp() {
        memory = .init()
        memory.game = .init()
    }
    
    func testChest() {
        let dialog = Dialog.chest(.potion)
        XCTAssertEqual("Dialog.Chest.Found", dialog.message.messages[0][0])
        XCTAssertEqual("Dialog.Chest.Obtained", dialog.message.messages[1][0])
        XCTAssertEqual("Item.potion", dialog.message.messages[1][1])
    }
    
    func testChestPicked() {
        let dialog = Dialog.chest(nil)
        XCTAssertEqual("Dialog.Chest.Found", dialog.message.messages[0][0])
        XCTAssertEqual("Dialog.Chest.Empty", dialog.message.messages[1][0])
    }
}
