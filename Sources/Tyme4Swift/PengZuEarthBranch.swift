import Foundation

/// 地支彭祖百忌
public class PengZuEarthBranch: LoopTyme {
    public static var NAMES: [String] = ["子不问卜自惹祸殃", "丑不冠带主不还乡", "寅不祭祀神鬼不尝", "卯不穿井水泉不香", "辰不哭泣必主重丧", "巳不远行财物伏藏", "午不苫盖屋主更张", "未不服药毒气入肠", "申不安床鬼祟入房", "酉不会客醉坐颠狂", "戌不吃犬作怪上床", "亥不嫁娶不利新郎"]

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
