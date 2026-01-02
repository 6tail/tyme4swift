import Foundation

/// 六曜（孔明六曜星）
public class SixStar: LoopTyme {
    public static var NAMES: [String] = ["先胜", "友引", "先负", "佛灭", "大安", "赤口"]

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
