@testable import Library
import XCTest

final class TestDialogPrototype: XCTestCase {
    func testOneDialog() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.player, [["hello world"]])])], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultitpleTexts() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.none, [["hello", "world"], ["lorem", "ipsum"]])])], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello", "world"], ["lorem", "ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testTwoMessages() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.none, [["hello"]]), (.player, [["world"]])])], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertNil(dialog.next?.next)
    }
    
    func testThreeMessages() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.none, [["hello"]]), (.player, [["world"]]), (.npc(id: .jung), [["lorem ipsum"]])])], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["hello"]], dialog.message)
        XCTAssertEqual(.player, dialog.next?.owner)
        XCTAssertEqual([["world"]], dialog.next?.message)
        XCTAssertEqual(.npc(id: .jung), dialog.next?.next?.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.next?.next?.message)
        XCTAssertNil(dialog.next?.next?.next)
    }
    
    func testMultipleSteps() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.player, [["hello world"]])]), .init(step: 1, tag: 0, messages: [(.none, [["lorem ipsum"]])])], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultipleStepsUnsorted() {
        let dialog = Dialog.prototypes([.init(step: 1, tag: 0, messages: [(.none, [["lorem ipsum"]])]), .init(step: 0, tag: 0, messages: [(.player, [["hello world"]])])], step: 0).first!
        XCTAssertEqual(.player, dialog.owner)
        XCTAssertEqual([["hello world"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testMultipleStepsSameValue() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.player, [["hello world"]])]), .init(step: 0, tag: 0, messages: [(.none, [["lorem ipsum"]])])], step: 0).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testLastStep() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.player, [["hello world"]])]), .init(step: 1, tag: 0, messages: [(.none, [["lorem ipsum"]])])], step: 1).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
    
    func testFutureStep() {
        let dialog = Dialog.prototypes([.init(step: 0, tag: 0, messages: [(.player, [["hello world"]])]), .init(step: 1, tag: 0, messages: [(.none, [["lorem ipsum"]])])], step: 2).first!
        XCTAssertEqual(.none, dialog.owner)
        XCTAssertEqual([["lorem ipsum"]], dialog.message)
        XCTAssertNil(dialog.next)
    }
}
