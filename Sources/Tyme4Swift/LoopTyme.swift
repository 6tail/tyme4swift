import Foundation

/// 可轮回的Tyme
public class LoopTyme: AbstractTyme {
    public private(set) var names: [String]
    public private(set) var index: Int

    init(_ names: [String], _ index: Int? = nil, _ name: String? = nil) throws {
        self.names = names
        let size: Int = names.count
        if let name: String = name {
            for i: Int in (0..<size) {
                if (names[i] == name) {
                    self.index = i
                    return
                }
            }
            throw ArgumentError("illegal name: \(name)")
        }
        if let index: Int = index {
            var i: Int = index % size
            if i < 0 {
                i += size
            }
            self.index = i
            return
        }
        throw ArgumentError("illegal index or name")
    }

    public override func getName() -> String {
        self.names[index]
    }
    
    public var size: Int {
        self.names.count
    }
    
    func indexOf(_ index: Int) -> Int {
        var i: Int = index % size
        if i < 0 {
            i += size
        }
        return i
    }
    
    func nextIndex(_ n: Int) -> Int {
        indexOf(index + n)
    }
    
    func stepsTo(_ targetIndex: Int) -> Int {
        indexOf(targetIndex - index)
    }
}
