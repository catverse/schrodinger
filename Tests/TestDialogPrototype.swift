@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    private var entry: Entry!
    
    override func setUp() {
        entry = .init()
    }
    
    func testOneDialog() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testMultitpleTexts() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello", "world"], ["lorem", "ipsum"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testTwoMessages() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello"]]), (.player, [["world"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertNil(dialog.next?.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testThreeMessages() {
        let dialog = Dialog.prototypes([[.init([(.none, [["hello"]]), (.player, [["world"]]), (.npc(id: .jung), [["lorem ipsum"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertEqual(.npc(id: .jung), dialog.next?.next?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.next?.next?.message)
        XCTAssertNil(dialog.next?.next?.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testMultipleSteps() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], entry: entry).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testMultipleStepsUnsorted() {
        let dialog = Dialog.prototypes([[.init([(.none, [["lorem ipsum"]])], step: 1), .init([(.player, [["hello world"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testMultipleStepsSameValue() {
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 0)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(0, entry.time.step)
    }
    
    func testLastStep() {
        entry.time.step = 1
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(1, entry.time.step)
    }
    
    func testFutureStep() {
        entry.time.step = 2
        let dialog = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)]], entry: entry).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
        XCTAssertEqual(2, entry.time.step)
    }
    
    func testMultipleNpc() {
        entry.time.step = 2
        let dialogs = Dialog.prototypes([
            [.init([(.player, [["hello world"]])], step: 0), .init([(.none, [["lorem ipsum"]])], step: 1)],
            [.init([(.npc(id: .jung), [["alpha"]])], step: 1), .init([(.player, [["beta"]])], step: 0)],
        ], entry: entry)
        XCTAssertEqual(Optional(Dialog.Owner.none), dialogs.first?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialogs.first?.message)
        XCTAssertNil(dialogs.first?.next)
        XCTAssertEqual(.npc(id: .jung), dialogs.last?.owner)
        XCTAssertEqual([["alpha"]], dialogs.last?.message)
        XCTAssertNil(dialogs.last?.next)
        XCTAssertEqual(2, entry.time.step)
    }
    
    func testIncreaseStep() {
        _ = Dialog.prototypes([[.init([(.player, [["hello world"]])], step: 0, increases: true)]], entry: entry).first!
        XCTAssertEqual(1, entry.time.step)
    }
}
