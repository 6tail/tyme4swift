import Foundation

/// 九野
public class Land: LoopTyme {
    public static var NAMES: [String] = ["玄天", "朱天", "苍天", "阳天", "钧天", "幽天", "颢天", "变天", "炎天"]

    required init(index: Int? = nil, name: String? = nil) throws {
        try super.init(Self.NAMES, index, name)
    }
    
    public class func fromIndex(_ index: Int) -> Self {
        try! Self(index: index)
    }
    
    public class func fromName(_ name: String) throws -> Self {
        try Self(name: name)
    }
    
    public override func next(_ n: Int) -> Self {
        Self.fromIndex(nextIndex(n))
    }
    
    /// 方位
    public func getDirection() -> Direction {
        Direction.fromIndex(index)
    }
}
