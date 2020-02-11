@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    func testOneDialog() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.player, [["hello world"]])])])
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultitpleMessages() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.none, [["hello", "world"], ["lorem", "ipsum"]])])])
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
}
