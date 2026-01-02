import Foundation

/// 天干（天元）
public class HeavenStem: LoopTyme {
    public static var NAMES: [String] = ["甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸"]

    required init(index: Int? = nil, name: String? = nil) throws {
        try super.init(Self.NAMES, index, name)
    }

    public class func fromIndex(_ index: Int) -> Self {
        try! Self(index: index)
    }

    public class func fromName(_ name: String) throws -> Self {
        try Self(name: name)
    }

    override public func next(_ n: Int) -> Self {
        Self.fromIndex(nextIndex(n))
    }

    /// 五行
    public var element: Element {
        Element.fromIndex(index / 2)
    }

    /// 阴阳
    public var yinYang: YinYang {
        index % 2 == 0 ? YinYang.YANG : YinYang.YIN
    }

    /// 方位
    public var direction: Direction {
        element.getDirection()
    }

    /// 喜神方位（《喜神方位歌》甲己在艮乙庚乾，丙辛坤位喜神安。丁壬只在离宫坐，戊癸原在在巽间。）
    public var joyDirection: Direction {
        Direction.fromIndex([7, 5, 1, 8, 3][index % 5])
    }

    /// 阳贵神方位（《阳贵神歌》甲戊坤艮位，乙己是坤坎，庚辛居离艮，丙丁兑与乾，震巽属何日，壬癸贵神安。）
    public var yangDirection: Direction {
        Direction.fromIndex([1, 1, 6, 5, 7, 0, 8, 7, 2, 3][index])
    }

    /// 阴贵神方位（《阴贵神歌》甲戊见牛羊，乙己鼠猴乡，丙丁猪鸡位，壬癸蛇兔藏，庚辛逢虎马，此是贵神方。）
    public var yinDirection: Direction {
        Direction.fromIndex([7, 0, 5, 6, 1, 1, 7, 8, 3, 2][index])
    }

    /// 财神方位（《财神方位歌》甲乙东北是财神，丙丁向在西南寻，戊己正北坐方位，庚辛正东去安身，壬癸原来正南坐，便是财神方位真。）
    public var wealthDirection: Direction {
        Direction.fromIndex([7, 1, 0, 2, 8][index / 2])
    }

    /// 福神方位（《福神方位歌》甲乙东南是福神，丙丁正东是堪宜，戊北己南庚辛坤，壬在乾方癸在西。）
    public var mascotDirection: Direction {
        Direction.fromIndex([3, 3, 2, 2, 0, 8, 1, 1, 5, 6][index])
    }

    /// 五合（甲己合，乙庚合，丙辛合，丁壬合，戊癸合）
    public var combine: HeavenStem {
        next(5)
    }

    /// 合化（甲己合化土，乙庚合化金，丙辛合化水，丁壬合化木，戊癸合化火）
    public func combine(_ target: HeavenStem) -> Element? {
        combine == target ? Element.fromIndex(index + 2) : nil
    }

    /// 十神（生我者，正印偏印。我生者，伤官食神。克我者，正官七杀。我克者，正财偏财。同我者，劫财比肩。）
    public func getTenStar(_ target: HeavenStem) -> TenStar {
        var offset: Int = target.index - index
        if index % 2 != 0 && target.index % 2 == 0 {
            offset += 2
        }
        return TenStar.fromIndex(offset)
    }
    
    /// 天干彭祖百忌
    public var pengZuHeavenStem: PengZuHeavenStem {
        PengZuHeavenStem.fromIndex(index)
    }
    
    /// 地势(长生十二神)
    public func getTerrain(_ earthBranch: EarthBranch) -> Terrain {
        Terrain.fromIndex([1, 6, 10, 9, 10, 9, 7, 0, 4, 3][index] + (YinYang.YANG == yinYang ? earthBranch.index : -earthBranch.index))
    }
}
