import Foundation
import simd

public struct Entry: Codable {
    public internal(set) var time = TimeInterval()
    public internal(set) var saved = TimeInterval()
    public internal(set) var location = Location.House_Bedroom
    public internal(set) var taken = [Location : [vector_int2]]()
    public internal(set) var inventory = [Item : Int]()
    public let id = UUID().uuidString
    public let created = Date().timeIntervalSince1970
}
