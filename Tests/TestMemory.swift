@testable import Library
import XCTest
import Combine

final class TestMemory: XCTestCase {
    private var memory: Memory!
    private var sub: AnyCancellable?
    
    override func setUp() {
        memory = .init()
        try? FileManager.default.removeItem(at: memory.url)
    }
    
    func testSave() {
        let expect = expectation(description: "")
        memory.game.value = .init()
        sub = memory.entries.sink {
            XCTAssertFalse($0.isEmpty)
            XCTAssertGreaterThan($0.first!.saved, 0)
            XCTAssertFalse(try! Data(contentsOf: self.memory.url.appendingPathComponent(self.memory.game.value!.id)).isEmpty)
            expect.fulfill()
        }
        memory.save()
        waitForExpectations(timeout: 1)
    }
}
