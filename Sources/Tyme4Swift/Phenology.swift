import Foundation

/// 候
public class Phenology: LoopTyme {
    public static var NAMES: [String] = ["蚯蚓结", "麋角解", "水泉动", "雁北乡", "鹊始巢", "雉始雊", "鸡始乳", "征鸟厉疾", "水泽腹坚", "东风解冻", "蛰虫始振", "鱼陟负冰", "獭祭鱼", "候雁北", "草木萌动", "桃始华", "仓庚鸣", "鹰化为鸠", "玄鸟至", "雷乃发声", "始电", "桐始华", "田鼠化为鴽", "虹始见", "萍始生", "鸣鸠拂其羽", "戴胜降于桑", "蝼蝈鸣", "蚯蚓出", "王瓜生", "苦菜秀", "靡草死", "麦秋至", "螳螂生", "鵙始鸣", "反舌无声", "鹿角解", "蜩始鸣", "半夏生", "温风至", "蟋蟀居壁", "鹰始挚", "腐草为萤", "土润溽暑", "大雨行时", "凉风至", "白露降", "寒蝉鸣", "鹰乃祭鸟", "天地始肃", "禾乃登", "鸿雁来", "玄鸟归", "群鸟养羞", "雷始收声", "蛰虫坯户", "水始涸", "鸿雁来宾", "雀入大水为蛤", "菊有黄花", "豺乃祭兽", "草木黄落", "蛰虫咸俯", "水始冰", "地始冻", "雉入大水为蜃", "虹藏不见", "天气上升地气下降", "闭塞而成冬", "鹖鴠不鸣", "虎始交", "荔挺出"]

    /// 年
    public private(set) var year: Int

    required init(year: Int, index: Int) throws {
        try SolarYear.validate(year)
        let size: Int = Self.NAMES.count
        self.year = (year * size + index) / size
        try super.init(Self.NAMES, index, nil)
    }

    required init(year: Int, name: String) throws {
        self.year = year
        try super.init(Self.NAMES, nil, name)
    }

    public class func fromIndex(_ year: Int, _ index: Int) throws -> Self {
        try Self(year: year, index: index)
    }

    public class func fromName(_ year: Int, _ name: String) throws -> Self {
        try Self(year: year, name: name)
    }

    public override func next(_ n: Int) throws -> Self {
        let i: Int = index + n
        return try Self.fromIndex((year * size + i) / size, indexOf(i))
    }

    /// 三候
    public var threePhenology: ThreePhenology {
        ThreePhenology.fromIndex(index % 3)
    }

    /// 儒略日
    public var julianDay: JulianDay {
        let t: Double = ShouXingUtil.saLonT(w: (Double(year) - 2000.0 + Double(index - 18) * 5.0 / 360.0 + 1.0) * 2.0 * Double.pi)
        return JulianDay.fromJulianDay(t * 36525.0 + JulianDay.J2000 + 8.0 / 24.0 - ShouXingUtil.dtT(t: t * 36525.0))
    }
}
