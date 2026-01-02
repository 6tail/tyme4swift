import Foundation

/// 地支
public class EarthBranch: LoopTyme {
    public static var NAMES: [String] = ["子", "丑", "寅", "卯", "辰", "巳", "午", "未", "申", "酉", "戌", "亥"]

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

    /// 五行
    public func getElement() -> Element {
        Element.fromIndex([4, 2, 0, 0, 2, 1, 1, 2, 3, 3, 2, 4][index])
    }

    /// 阴阳
    public func getYinYang() -> YinYang {
        index % 2 == 0 ? YinYang.YANG : YinYang.YIN
    }

    /// 生肖
    public func getZodiac() -> Zodiac {
        Zodiac.fromIndex(index)
    }

    /// 方位
    public func getDirection() -> Direction {
        Direction.fromIndex([0, 4, 2, 2, 4, 8, 8, 4, 6, 6, 4, 0][index])
    }

    /// 煞（逢巳日、酉日、丑日必煞东；亥日、卯日、未日必煞西；申日、子日、辰日必煞南；寅日、午日、戌日必煞北。）
    public func getOminous() -> Direction {
        Direction.fromIndex([8, 2, 0, 6][index % 4])
    }

    /// 六冲（子午冲，丑未冲，寅申冲，辰戌冲，卯酉冲，巳亥冲）
    public func getOpposite() -> EarthBranch {
        next(6)
    }

    /// 六合（子丑合，寅亥合，卯戌合，辰酉合，巳申合，午未合）
    public func getCombine() -> EarthBranch {
        Self.fromIndex(1 - index)
    }

    /// 六害（子未害、丑午害、寅巳害、卯辰害、申亥害、酉戌害）
    public func getHarm() -> EarthBranch {
        Self.fromIndex(19 - index)
    }

    /// 合化（子丑合化土，寅亥合化木，卯戌合化火，辰酉合化金，巳申合化水，午未合化土）
    public func combine(_ target: EarthBranch) -> Element? {
        getCombine() == target ? Element.fromIndex([2, 2, 0, 1, 3, 4, 2, 2, 4, 3, 1, 0][index]) : nil
    }

    /// 藏干之本气
    public var hideHeavenStemMain: HeavenStem {
        HeavenStem.fromIndex([9, 5, 0, 1, 4, 2, 3, 5, 6, 7, 4, 8][index])
    }

    /// 藏干之中气，无中气为nil
    public var hideHeavenStemMiddle: HeavenStem? {
        let n: Int = [-1, 9, 2, -1, 1, 6, 5, 3, 8, -1, 7, 0][index]
        return n == -1 ? nil : HeavenStem.fromIndex(n)
    }

    /// 藏干之余气，无余气为nil
    public var hideHeavenStemResidual: HeavenStem? {
        let n: Int = [-1, 7, 4, -1, 9, 4, -1, 1, 4, -1, 3, -1][index]
        return n == -1 ? nil : HeavenStem.fromIndex(n)
    }

    /// 藏干列表
    public var hideHeavenStems: [HideHeavenStem] {
        var l: [HideHeavenStem] = [HideHeavenStem]()
        l.append(HideHeavenStem(hideHeavenStemMain, HideHeavenStemType.MAIN))
        var o: HeavenStem? = hideHeavenStemMiddle
        if o != nil {
            l.append(HideHeavenStem(o!, HideHeavenStemType.MIDDLE))
        }
        o = hideHeavenStemResidual
        if o != nil {
            l.append(HideHeavenStem(o!, HideHeavenStemType.RESIDUAL))
        }
        return l
    }
}
