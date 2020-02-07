import Foundation
import simd

public struct Entry: Codable {
    public var location = Location()
    public var time = Time()
    public internal(set) var id = UUID().uuidString
    public internal(set) var player = Player()
    public internal(set) var items = Items()
    
    public struct Time: Codable {
        public var played = TimeInterval()
        public internal(set) var saved = TimeInterval()
        public let created = Date().timeIntervalSince1970
    }
    
    public struct Location: Codable {
        public var id = LocationId.House_Bedroom
        public var facing = Direction.down
        public var position = vector_int2(1, 10)
    }
    
    public struct Player: Codable {
        public internal(set) var level = 1
        public internal(set) var hp = Gauge()
        public internal(set) var mp = Gauge()
        
        public struct Gauge: Codable {
            public internal(set) var current = 20
            public internal(set) var max = 20
        }
    }
    
    public struct Items: Codable {
        public internal(set) var taken = [LocationId : [vector_int2]]()
        public internal(set) var inventory = [ItemId : Int]()
    }
}
