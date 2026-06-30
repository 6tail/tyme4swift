import Foundation

/// 公历年
public class SolarYear: YearUnit {

    required override init(_ year: Int) throws {
        try Self.validate(year)
        try super.init(year)
    }
    
    public class func validate(_ year: Int) throws {
        try validateRange(year, 1, 9999, "solar year")
    }

    public class func fromYear(_ year: Int) throws -> Self {
        try Self(year)
    }

    /// 天数（1582年355天，平年365天，闰年366天）
    public var dayCount: Int {
        if 1582 == year {
            return 355
        }
        return isLeap ? 366 : 365
    }

    /// 是否闰年(1582年以前，使用儒略历，能被4整除即为闰年。以后采用格里历，四年一闰，百年不闰，四百年再闰。)
    public var isLeap: Bool {
        if year < 1600 {
            return year % 4 == 0
        }
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    public override func getName() -> String {
        "\(year)年"
    }
    
    public override func next(_ n: Int) throws -> Self {
        try Self.fromYear(year + n)
    }
    
    /// 半年列表
    public var halfYears: [SolarHalfYear] {
        var l: [SolarHalfYear] = [SolarHalfYear]()
        for i: Int in (0..<2) {
            l.append(try! SolarHalfYear.fromIndex(year, i))
        }
        return l
    }
    
    /// 季度列表
    public var seasons: [SolarSeason] {
        var l: [SolarSeason] = [SolarSeason]()
        for i: Int in (0..<4) {
            l.append(try! SolarSeason.fromIndex(year, i))
        }
        return l
    }
    
    /// 月份列表
    public var months: [SolarMonth] {
        var l: [SolarMonth] = [SolarMonth]()
        for i: Int in (1..<13) {
            l.append(try! SolarMonth.fromYm(year, i))
        }
        return l
    }
}
