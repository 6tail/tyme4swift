import Foundation

/// 回历日
public class HijriDay: DayUnit {
    public static var NAMES: [String] = ["1日", "2日", "3日", "4日", "5日", "6日", "7日", "8日", "9日", "10日", "11日", "12日", "13日", "14日", "15日", "16日", "17日", "18日", "19日", "20日", "21日", "22日", "23日", "24日", "25日", "26日", "27日", "28日", "29日", "30日"]

    public override required init(_ year: Int, _ month: Int, _ day: Int) throws {
        try Self.validate(year, month, day)
        try super.init(year, month, day)
    }

    public class func validate(_ year: Int, _ month: Int, _ day: Int) throws {
        let m: HijriMonth = try HijriMonth.fromYm(year, month)
        if day < 1 || day > m.dayCount {
            throw ArgumentError("illegal hijri day: \(year)-\(month)-\(day)")
        }
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> Self {
        try Self(year, month, day)
    }
    
    /// 回历月
    public var hijriMonth: HijriMonth {
        try! HijriMonth.fromYm(year, month)
    }

    public override func getName() -> String {
        Self.NAMES[day - 1]
    }
    
    public override var description: String {
        "\(hijriMonth)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        let d: SolarDay = try getSolarDay().next(n)
        let h: HijriDay = d.getHijriDay()
        return try Self.fromYmd(h.year, h.month, h.day)
    }

    public func getJulianDay() -> JulianDay {
        let y: Double = Double(floorDiv(11 * year + 3, 30))
        let m: Double = Double(floorDiv(month - 1, 2))
        return JulianDay.fromJulianDay(y + 354 * Double(year) + 30 * Double(month) - m + Double(day) + 1948055)
    }

    public func isBefore(_ target: HijriDay) -> Bool {
        getCompareIndex() < target.getCompareIndex()
    }

    public func isAfter(_ target: HijriDay) -> Bool {
        getCompareIndex() > target.getCompareIndex()
    }

    public func subtract(_ target: HijriDay) -> Int {
        Int(getJulianDay().subtract(target.getJulianDay()))
    }

    /// 位于当年的索引
    public var indexInYear: Int {
        let d: HijriDay = try! HijriDay.fromYmd(year, 1, 1)
        return subtract(d)
    }

    /// 公历日
    public func getSolarDay() -> SolarDay {
        let d: SolarDay = try! SolarDay.fromYmd(622, 7, 16)
        let h: HijriDay = try! HijriDay.fromYmd(1, 1, 1)
        return try! d.next(subtract(h))
    }
}
