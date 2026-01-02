import Foundation

/// 黄道黑道十二神
public class TwelveStar: LoopTyme {
    public static var NAMES: [String] = ["青龙", "明堂", "天刑", "朱雀", "金匮", "天德", "白虎", "玉堂", "天牢", "玄武", "司命", "勾陈"]

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
    
    /// 黄道黑道
    public var ecliptic: Ecliptic {
        Ecliptic.fromIndex([0, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 1][index])
    }
}
