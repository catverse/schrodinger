import Foundation

public struct Entry: Codable {
    public internal(set) var time = TimeInterval()
    public internal(set) var saved = TimeInterval()
    public internal(set) var location = Location.House_Bedroom
    public let id = UUID().uuidString
    public let created = Date().timeIntervalSince1970
    
}
