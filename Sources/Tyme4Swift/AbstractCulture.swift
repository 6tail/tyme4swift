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
    
    public func floorDiv(_ a: Int, _ b: Int) -> Int {
        let q: Int = a / b
        let r: Int = a % b
        // 如果余数不为0，且符号不同（a为负），则向负无穷方向减1
        if r != 0 && ((a < 0) != (b < 0)) {
            return q - 1
        }
        return q
    }
    
    public class func validateRange(_ value: Int, _ min: Int, _ max: Int, _ field: String) throws {
        if value < min || value > max {
            throw ArgumentError("illegal \(field): \(value)")
        }
    }
}
