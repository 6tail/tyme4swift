import Foundation

/// 神兽
public class Beast: LoopTyme {
    public static var NAMES: [String] = ["青龙", "玄武", "白虎", "朱雀"]

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
    
    /// 宫
    public func getZone() -> Zone {
        Zone.fromIndex(index)
    }
}
