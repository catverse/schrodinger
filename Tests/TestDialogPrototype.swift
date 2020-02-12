@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    func testOneDialog() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultitpleTexts() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello", "world"], ["lorem", "ipsum"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testTwoMessages() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello"]]), (.player, [["world"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertNil(dialog.next?.next)
    }
    
    func testThreeMessages() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello"]]), (.player, [["world"]]), (.npc(id: .jung), [["lorem ipsum"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertEqual(.npc(id: .jung), dialog.next?.next?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.next?.next?.message)
        XCTAssertNil(dialog.next?.next?.next)
    }
    
    func testMultipleSteps() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultipleStepsUnsorted() {
        let dialog = Dialog.prototypes([[.init([(.none, [["lorem ipsum"]])], step: 1), .init([(.player, [["hello world"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultipleStepsSameValue() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 0)]], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testLastStep() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], step: 1).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testFutureStep() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], step: 2).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultipleNpc() {
        let dialogs = Dialog.prototypes([
            [.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)],
            [.init([(.npc(id: .jung), [["alpha"]])], step: 1), .init([(.player, [["beta"]])], step: 0)],
        ], step: 2)
        XCTAssertEqual(Optional(Dialog.Owner.none), dialogs.first?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialogs.first?.message)
        XCTAssertNil(dialogs.first?.next)
        XCTAssertEqual(.npc(id: .jung), dialogs.last?.owner)
        XCTAssertEqual([["alpha"]], dialogs.last?.message)
        XCTAssertNil(dialogs.last?.next)
    }
}
