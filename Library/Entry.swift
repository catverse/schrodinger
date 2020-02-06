import Foundation
import simd

public struct Entry: Codable {
    public var location = Location.House_Bedroom
    public var time = TimeInterval()
    public var position = vector_int2(1, 10)
    public var facing = Direction.down
    public internal(set) var id = UUID().uuidString
    public internal(set) var saved = TimeInterval()
    public internal(set) var taken = [Location : [vector_int2]]()
    public internal(set) var inventory = [ItemId : Int]()
    public internal(set) var player = Player()
    public let created = Date().timeIntervalSince1970
    
    public struct Player: Codable {
        public internal(set) var level = 1
        public internal(set) var hp = Gauge()
        public internal(set) var mp = Gauge()
    }
    
    public struct Gauge: Codable {
        public internal(set) var current = 0
        public internal(set) var max = 0
    }
}
