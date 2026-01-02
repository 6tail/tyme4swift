import Foundation

/// 天干六甲胎神（《天干六甲胎神歌》甲己之日占在门，乙庚碓磨休移动。丙辛厨灶莫相干，丁壬仓库忌修弄。戊癸房床若移整，犯之孕妇堕孩童。）
public class FetusHeavenStem: LoopTyme {
    public static var NAMES: [String] = ["门", "碓磨", "厨灶", "仓库", "房床"]

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
