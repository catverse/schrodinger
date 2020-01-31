import Foundation
import simd

public struct Entry: Codable {
    public var location = Location.House_Bedroom
    public var time = TimeInterval()
    public var position = vector_int2()
    public var facing = Direction.down
    public internal(set) var id = UUID().uuidString
    public internal(set) var saved = TimeInterval()
    public internal(set) var taken = [Location : [vector_int2]]()
    public internal(set) var inventory = [Item : Int]()
    public let created = Date().timeIntervalSince1970
}
