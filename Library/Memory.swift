import Foundation
import Combine
import simd

public final class Memory {
    public var game: Entry!
    public var time = TimeInterval()
    public let entries = PassthroughSubject<[Entry], Never>()
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Memory")
    private let queue = DispatchQueue(label: "", qos: .background, target: .global(qos: .background))
    
    public init() {
        
    }
    
    public func new() {
        game = .init()
        save()
    }
    
    public func duplicate() {
        game.id = UUID().uuidString
        save()
    }
    
    public func save() {
        queue.async {
            self.prepare()
            self.game.time.saved = Date().timeIntervalSince1970
            try! (JSONEncoder().encode(self.game) as NSData).compressed(using: .lzfse).write(to: self.url.appendingPathComponent(self.game.id), atomically: true)
            self.load()
        }
    }
    
    public func load() {
        queue.async {
            var entries = [Entry]()
            try? FileManager.default.contentsOfDirectory(at: self.url, includingPropertiesForKeys: nil, options: []).forEach {
                if let entry = try? JSONDecoder().decode(Entry.self, from: NSData(contentsOf: $0).decompressed(using: .lzfse) as Data) {
                    entries.append(entry)
                }
            }
            self.entries.send(entries.sorted { $0.time.saved > $1.time.saved })
        }
    }
    
    public func take(chest: vector_int2, item: ItemId) -> Dialog {
        guard game.items.taken[game.location.id]?.contains(chest) != true else { return Dialog.chest(nil) }
        game.items.taken[game.location.id] = [chest] + (game.items.taken[game.location.id] ?? [])
        game.items.inventory[item] = 1 + (game.items.inventory[item] ?? 0)
        return Dialog.chest(item)
    }
    
    func prepare() {
        var root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var resources = URLResourceValues()
        resources.isExcludedFromBackup = true
        try! root.setResourceValues(resources)
        try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
    }
}
