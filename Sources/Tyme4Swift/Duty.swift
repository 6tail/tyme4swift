import Foundation

/// 建除十二值神
public class Duty: LoopTyme {
    public static var NAMES: [String] = ["建", "除", "满", "平", "定", "执", "破", "危", "成", "收", "开", "闭"]

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
