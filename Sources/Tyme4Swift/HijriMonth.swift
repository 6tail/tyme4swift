import Foundation

/// 回历月
public class HijriMonth: MonthUnit {
    public static var NAMES: [String] = ["穆哈兰姆月", "色法尔月", "赖比尔·敖外鲁月", "赖比尔·阿色尼月", "主马达·敖外鲁月", "主马达·阿色尼月", "赖哲卜月", "舍尔邦月", "赖买丹月", "闪瓦鲁月", "都尔喀尔德月", "都尔黑哲月"]

    required override init(_ year: Int, _ month: Int) throws {
        try Self.validate(year, month)
        try super.init(year, month)
    }
    
    public class func validate(_ year: Int, _ month: Int) throws {
        try validateRange(month, 1, 12, "hijri month")
        try HijriYear.validate(year)
    }

    public class func fromYm(_ year: Int, _ month: Int) throws -> Self {
        try Self(year, month)
    }

    /// 位于当年的索引(0-11)
    public var indexInYear: Int {
        month - 1
    }

    /// 天数（单数月30天，双数月29天，闰年第12月30天)
    public var dayCount: Int {
        var d: Int = month % 2 == 0 ? 29 : 30
        // 闰年第12月30天
        if month == 12 && hijriYear.isLeap {
            d += 1
        }
        return d
    }
    
    /// 回历年
    public var hijriYear: HijriYear {
        try! HijriYear.fromYear(year)
    }

    public override func getName() -> String {
        Self.NAMES[indexInYear]
    }
    
    public override var description: String {
        "\(hijriYear)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        let i: Int = indexInYear + n
        return try Self.fromYm((year * 12 + i) / 12, indexOf(i, 12) + 1)
    }
    
    /// 首日
    public var firstDay: HijriDay {
        try! HijriDay.fromYmd(year, month, 1)
    }
    
    /// 本月的回历日列表
    public var days: [HijriDay] {
        var l: [HijriDay] = [HijriDay]()
        for i: Int in (1...dayCount) {
            l.append(try! HijriDay.fromYmd(year, month, i))
        }
        return l
    }
}
