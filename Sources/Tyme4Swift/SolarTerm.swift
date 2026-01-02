import Foundation

/// 节气
public class SolarTerm: LoopTyme {
    public static var NAMES: [String] = ["冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏", "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑", "白露", "秋分", "寒露", "霜降", "立冬", "小雪", "大雪"]

    /// 年
    public private(set) var year: Int = 0
    
    /// 儒略日（用于日历，只精确到日中午12:00）
    public private(set) var cursoryJulianDay: Double = 0
    
    required init(_ year: Int, index: Int? = nil, name: String? = nil) throws {
        try super.init(Self.NAMES, index, name)
        var y: Int = year
        let n: Int = size
        if let i: Int = index {
            y = (year * n + i) / n
        }
        let jd: Double = floor(Double(y - 2000) * 365.2422 + 180.0)
        // 355是2000.12冬至，得到较靠近jd的冬至估计值
        var w: Double = floor((jd - 172.0) / 365.2422) * 365.2422 + 355.0
        if ShouXingUtil.calcQi(w) > jd {
            w -= 365.2422
        }
        self.year = year
        cursoryJulianDay = ShouXingUtil.calcQi(w + 15.2184 * Double(self.index))
    }
    
    public class func fromIndex(_ year: Int, _ index: Int) -> Self {
        try! Self(year, index: index)
    }
    
    public class func fromName(_ year: Int, _ name: String) throws -> Self {
        try Self(year, name: name)
    }
    
    public override func next(_ n: Int) -> Self {
        let i: Int = index + n
        return Self.fromIndex((year * size + i) / size, indexOf(i))
    }
    
    /// 是否节令
    public var isJie: Bool {
        index % 2 == 1
    }
    
    /// 是否气令
    public var isQi: Bool {
        index % 2 == 0
    }
    
    /// 儒略日（精确到秒）
    public var julianDay: JulianDay {
        JulianDay.fromJulianDay(ShouXingUtil.qiAccurate2(cursoryJulianDay) + JulianDay.J2000)
    }
    
    /// 公历日（用于日历）
    public func getSolarDay() -> SolarDay {
        JulianDay.fromJulianDay(cursoryJulianDay + JulianDay.J2000).getSolarDay()
    }
}
