import Foundation

/// 传统文化抽象
public class AbstractCulture: NSObject, Culture {
    public override var description: String {
        getName()
    }

    func getName() -> String {
        fatalError("not implement")
    }

    public override func isEqual(_ t: Any?) -> Bool {
        guard let other = t as? AbstractCulture else {
            return false
        }
        return description == other.description
    }

    public func indexOf(_ index: Int, _ size: Int) -> Int {
        var i: Int = index % size
        if i < 0 {
            i += size
        }
        return i
    }
}
