@testable import Library
import XCTest

final class TestDialog: XCTestCase {
    private var memory: Memory!
    
    override func setUp() {
        memory = .init()
        memory.game.value = .init()
    }
    
    func testChest() {
        let dialog = Dialog.chest(.Potion)
        XCTAssertEqual("Dialog.Chest.Found", dialog[0][0])
        XCTAssertEqual("Dialog.Chest.Obtained", dialog[1][0])
        XCTAssertEqual("Item.Potion", dialog[1][1])
    }
    
    func testChestPicked() {
        let dialog = Dialog.chest(nil)
        XCTAssertEqual("Dialog.Chest.Found", dialog[0][0])
        XCTAssertEqual("Dialog.Chest.Empty", dialog[1][0])
    }
}
