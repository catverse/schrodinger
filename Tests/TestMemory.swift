@testable import Library
import XCTest
import Combine

final class TestMemory: XCTestCase {
    private var memory: Memory!
    private var subs: Set<AnyCancellable>!
    
    override func setUp() {
        memory = .init()
        subs = .init()
        try? FileManager.default.removeItem(at: memory.url)
    }
    
    func testSave() {
        let expect = expectation(description: "")
        memory.game = .init()
        memory.entries.sink {
            XCTAssertFalse($0.isEmpty)
            XCTAssertGreaterThan($0.first!.saved, 0)
            XCTAssertFalse(try! Data(contentsOf: self.memory.url.appendingPathComponent(self.memory.game.id)).isEmpty)
            expect.fulfill()
        }.store(in: &subs)
        memory.save()
        waitForExpectations(timeout: 1)
    }
    
    func testDuplicate() {
        let expect = expectation(description: "")
        memory.game = .init()
        let id = memory.game.id
        memory.entries.sink { _ in
            XCTAssertNotEqual(id, self.memory.game.id)
            expect.fulfill()
        }.store(in: &subs)
        memory.duplicate()
        waitForExpectations(timeout: 1)
    }
    
    func testNewGame() {
        let expect = expectation(description: "")
        memory.entries.sink {
            XCTAssertFalse($0.isEmpty)
            expect.fulfill()
        }.store(in: &subs)
        memory.new()
        waitForExpectations(timeout: 1)
    }
    
    func testTakeChest() {
        memory.game = .init()
        _ = memory.take(chest: .init(0, 0), item: .potion)
        XCTAssertEqual([.init(0, 0)], memory.game.taken[.House_Bedroom])
        XCTAssertEqual(1, memory.game.inventory[.potion])
    }
    
    func testTakeChestTaken() {
        memory.game = .init()
        memory.game.taken[.House_Bedroom] = [.init(0, 0)]
        _ = memory.take(chest: .init(0, 0), item: .potion)
        XCTAssertEqual(1, memory.game.taken[.House_Bedroom]!.count)
        XCTAssertNil(memory.game.inventory[.potion])
    }
}
