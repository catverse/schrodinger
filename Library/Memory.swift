import Foundation
import Combine

public final class Memory {
    public let game = CurrentValueSubject<Entry?, Never>(nil)
    public let entries = PassthroughSubject<[Entry], Never>()
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("Memory")
    private let queue = DispatchQueue(label: "", qos: .background, target: .global(qos: .background))
    
    public init() {

    }
    
    public func save() {
        queue.async {
            if self.game.value != nil {
                self.prepare()
                self.game.value!.saved = Date().timeIntervalSince1970
                try! (JSONEncoder().encode(self.game.value!) as NSData).compressed(using: .lzfse)
                    .write(to: self.url.appendingPathComponent(self.game.value!.id), atomically: true)
                self.load()
            }
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
            self.entries.send(entries.sorted { $0.saved > $1.saved })
        }
    }
    
    func prepare() {
        var root = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        var resources = URLResourceValues()
        resources.isExcludedFromBackup = true
        try! root.setResourceValues(resources)
        try! FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
    }
}
