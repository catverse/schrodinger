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
        memory.game.value = .init()
        memory.entries.sink {
            XCTAssertFalse($0.isEmpty)
            XCTAssertGreaterThan($0.first!.saved, 0)
            XCTAssertFalse(try! Data(contentsOf: self.memory.url.appendingPathComponent(self.memory.game.value!.id)).isEmpty)
            expect.fulfill()
        }.store(in: &subs)
        memory.save()
        waitForExpectations(timeout: 1)
    }
    
    func testNewGame() {
        let expectGame = expectation(description: "")
        let expectLoad = expectation(description: "")
        memory.game.sink {
            if $0 != nil {
                expectGame.fulfill()
            }
        }.store(in: &subs)
        memory.entries.sink {
            XCTAssertFalse($0.isEmpty)
            expectLoad.fulfill()
        }.store(in: &subs)
        memory.new()
        waitForExpectations(timeout: 1)
    }
    
    func testTakeChest() {
        memory.game.value = .init()
        _ = memory.take(chest: .House_Bedroom, index: 0, item: .Potion)
        XCTAssertEqual([0], memory.game.value!.taken[.House_Bedroom])
        XCTAssertEqual(1, memory.game.value!.inventory[.Potion])
    }
    
    func testTakeChestTaken() {
        memory.game.value = .init()
        memory.game.value!.taken[.House_Bedroom] = [0]
        _ = memory.take(chest: .House_Bedroom, index: 0, item: .Potion)
        XCTAssertEqual(1, memory.game.value!.taken[.House_Bedroom]!.count)
        XCTAssertNil(memory.game.value!.inventory[.Potion])
    }
}
