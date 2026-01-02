import Foundation

/// 星期
public class Week: LoopTyme {
    public static var NAMES: [String] = ["日", "一", "二", "三", "四", "五", "六"]

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
    
    /// 七曜
    public func getSevenStar() -> SevenStar {
        SevenStar.fromIndex(index)
    }
}
