import Foundation

/// 数九
public class Nine: LoopTyme {
    public static var NAMES: [String] = ["一九", "二九", "三九", "四九", "五九", "六九", "七九", "八九", "九九"]

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
}
