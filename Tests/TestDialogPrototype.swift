@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    func testOneDialog() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.player, [["hello world"]])])])
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultitpleTexts() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.none, [["hello", "world"], ["lorem", "ipsum"]])])])
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testTwoMessages() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.none, [["hello"]]),
                                                                                         (.player, [["world"]])])])
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertNil(dialog.next?.next)
    }
    
    func testThreeMessages() {
        let dialog = Dialog.prototypes([.init(step: 0, position: .init(0, 0), messages: [(.none, [["hello"]]),
                                                                                         (.player, [["world"]]),
                                                                                         (.npc(id: .jung), [["lorem ipsum"]])])])
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertEqual(.npc(id: .jung), dialog.next?.next?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.next?.next?.message)
        XCTAssertNil(dialog.next?.next?.next)
    }
}
