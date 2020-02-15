@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    func testOneDialog() {
        let dialog = Dialog.npc([[.init([.init(.player, [["hello world"]])])]]).first!.first!
        XCTAssertEqual(.player, dialog.message.owner)
        XCTAssertEqual([["hello world"]], dialog.message.messages)
        XCTAssertNil(dialog.next)
    }
    
    func testMultitpleTexts() {
        let dialog = Dialog.npc([[.init([.init(.none, [["hello", "world"], ["lorem", "ipsum"]])])]]).first!.first!
        XCTAssertEqual(.none, dialog.message.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message.messages)
        XCTAssertNil(dialog.next)
    }
    
    func testTwoMessages() {
        let dialog = Dialog.npc([[.init([.init(.none, [["hello"]]), .init(.player, [["world"]])])]]).first!.first!
        XCTAssertEqual(.none, dialog.message.owner)
        XCTAssertEqual([["hello"]], dialog.message.messages)
        XCTAssertEqual(.player, dialog.next?.message.owner)
        XCTAssertEqual([["world"]], dialog.next?.message.messages)
        XCTAssertNil(dialog.next?.next)
    }
    
    func testThreeMessages() {
        let dialog = Dialog.npc([[.init([.init(.none, [["hello"]]), .init(.player, [["world"]]), .init(.npc(id: .jung), [["lorem ipsum"]])])]]).first!.first!
        XCTAssertEqual(.none, dialog.message.owner)
        XCTAssertEqual([["hello"]], dialog.message.messages)
        XCTAssertEqual(.player, dialog.next?.message.owner)
        XCTAssertEqual([["world"]], dialog.next?.message.messages)
        XCTAssertEqual(.npc(id: .jung), dialog.next?.next?.message.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.next?.next?.message.messages)
        XCTAssertNil(dialog.next?.next?.next)
    }
    
    func testMultipleNpc() {
        let dialogs = Dialog.npc([
            [.init([.init(.player, [["hello world"]])]), .init([.init(.none, [["lorem ipsum"]])])],
            [.init([.init(.npc(id: .jung), [["alpha"]])]), .init([.init(.player, [["beta"]])])]
        ])
        XCTAssertEqual(Optional(Dialog.Owner.player), dialogs.first?.first?.message.owner)
        XCTAssertEqual(Optional(Dialog.Owner.none), dialogs.first?.last?.message.owner)
        XCTAssertEqual([["hello world"]], dialogs.first?.first?.message.messages)
        XCTAssertEqual([["lorem ipsum"]], dialogs.first?.last?.message.messages)
        XCTAssertNil(dialogs.first?.first?.next)
        XCTAssertNil(dialogs.first?.last?.next)
        XCTAssertEqual(.npc(id: .jung), dialogs.last?.first?.message.owner)
        XCTAssertEqual(.player, dialogs.last?.last?.message.owner)
        XCTAssertEqual([["alpha"]], dialogs.last?.first?.message.messages)
        XCTAssertEqual([["beta"]], dialogs.last?.last?.message.messages)
        XCTAssertNil(dialogs.last?.first?.next)
        XCTAssertNil(dialogs.last?.last?.next)
    }
}
