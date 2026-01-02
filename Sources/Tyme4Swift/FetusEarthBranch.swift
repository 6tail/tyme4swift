import Foundation

/// 地支六甲胎神（《地支六甲胎神歌》子午二日碓须忌，丑未厕道莫修移。寅申火炉休要动，卯酉大门修当避。辰戌鸡栖巳亥床，犯着六甲身堕胎。）
public class FetusEarthBranch: LoopTyme {
    public static var NAMES: [String] = ["碓", "厕", "炉", "门", "栖", "床"]

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
