import Foundation

/// 七曜（七政、七纬、七耀）
public class SevenStar: LoopTyme {
    public static var NAMES: [String] = ["日", "月", "火", "水", "木", "金", "土"]

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
    
    /// 星期
    public func getWeek() -> Week {
        Week.fromIndex(index)
    }
}
