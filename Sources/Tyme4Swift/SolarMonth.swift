import Foundation

/// 公历月
public class SolarMonth: MonthUnit {
    public static var NAMES: [String] = ["1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
    /// 每月天数
    public static var DAYS: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    required override init(_ year: Int, _ month: Int) throws {
        try Self.validate(year, month)
        try super.init(year, month)
    }
    
    public class func validate(_ year: Int, _ month: Int) throws {
        if month < 1 || month > 12 {
            throw ArgumentError("illegal solar month: \(month)")
        }
        try SolarYear.validate(year)
    }

    public class func fromYm(_ year: Int, _ month: Int) throws -> Self {
        try Self(year, month)
    }

    /// 位于当年的索引(0-11)
    public var indexInYear: Int {
        month - 1
    }

    /// 天数（1582年10月只有21天)
    public var dayCount: Int {
        if 1582 == year && 10 == month {
            return 21
        }
        var d: Int = Self.DAYS[indexInYear]
        // 公历闰年2月多一天
        if 2 == month && (try! SolarYear.fromYear(year)).isLeap {
            d += 1
        }
        return d
    }
    
    /// 公历年
    public var solarYear: SolarYear {
        try! SolarYear.fromYear(year)
    }
    
    /// 公历季度
    public var solarSeason: SolarSeason {
        try! SolarSeason.fromIndex(year, indexInYear / 3)
    }

    public override func getName() -> String {
        Self.NAMES[indexInYear]
    }
    
    public override var description: String {
        "\(solarYear)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        let i: Int = indexInYear + n
        return try Self.fromYm((year * 12 + i) / 12, indexOf(i, 12) + 1)
    }
    
    /// 周数
    public func getWeekCount(_ start: Int) -> Int {
        Int(ceil(Double(indexOf(try! SolarDay.fromYmd(year, month, 1).week.index - start, 7) + dayCount) / 7.0))
    }
    
    /// 本月的公历周列表
    public func getWeeks(_ start: Int) -> [SolarWeek] {
        var l: [SolarWeek] = [SolarWeek]()
        let size: Int = getWeekCount(start)
        for i: Int in (1..<size) {
            l.append(try! SolarWeek.fromYm(year, month, i, start))
        }
        return l
    }
    
    /// 本月第1天
    public var firstDay: SolarDay {
        try! SolarDay.fromYmd(year, month, 1)
    }
    
    /// 本月的公历日列表
    public var days: [SolarDay] {
        var l: [SolarDay] = [SolarDay]()
        for i: Int in (1...dayCount) {
            l.append(try! SolarDay.fromYmd(year, month, i))
        }
        return l
    }
}
