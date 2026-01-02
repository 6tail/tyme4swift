/// 黄道黑道
public class Ecliptic: LoopTyme {
    public static var NAMES: [String] = ["黄道", "黑道"]

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
    
    /// 吉凶
    public var luck: Luck {
        Luck.fromIndex(index)
    }
}
