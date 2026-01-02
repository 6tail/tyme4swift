import Foundation

/// 月相
public class Phase: LoopTyme {
    public static var NAMES: [String] = ["新月", "蛾眉月", "上弦月", "盈凸月", "满月", "亏凸月", "下弦月", "残月"]
    
    /// 农历年
    public private(set) var lunarYear: Int
    
    /// 农历月
    public private(set) var lunarMonth: Int

    required init(lunarYear: Int, lunarMonth: Int, index: Int) throws {
        let m: LunarMonth = try LunarMonth.fromYm(lunarYear, lunarMonth).next(index / Self.NAMES.count)
        self.lunarYear = m.year
        self.lunarMonth = m.monthWithLeap
        try super.init(Self.NAMES, index, nil)
    }
    
    required init(lunarYear: Int, lunarMonth: Int, name: String) throws {
        try LunarMonth.validate(lunarYear, lunarMonth)
        self.lunarYear = lunarYear
        self.lunarMonth = lunarMonth
        try super.init(Self.NAMES, nil, name)
    }
    
    public class func fromIndex(_ lunarYear: Int, _ lunarMonth: Int, _ index: Int) throws -> Self {
        try Self(lunarYear: lunarYear, lunarMonth: lunarMonth, index: index)
    }
    
    public class func fromName(_ lunarYear: Int, _ lunarMonth: Int, _ name: String) throws -> Self {
        try Self(lunarYear: lunarYear, lunarMonth: lunarMonth, name: name)
    }
    
    public override func next(_ n: Int) throws -> Self {
        var i = index + n;
        if i < 0 {
            i -= size
        }

        i /= size
        var m = try LunarMonth.fromYm(lunarYear, lunarMonth)
        if i != 0 {
            m = try m.next(i)
        }

        return try Self.fromIndex(m.year, m.monthWithLeap, nextIndex(n))
    }
    
    var startSolarTime: SolarTime {
        let n: Int = Int(floor(Double(lunarYear - 2000) * 365.2422 / 29.53058886))
        var i: Int = 0
        let jd: Double = JulianDay.J2000 + ShouXingUtil.ONE_THIRD
        let d: SolarDay = try! LunarDay.fromYmd(lunarYear, lunarMonth, 1).getSolarDay()
        while true {
            let t: Double = ShouXingUtil.msaLonT(w: Double(n + i) * ShouXingUtil.PI_2) * 36525.0
            if !JulianDay.fromJulianDay(jd + t  - ShouXingUtil.dtT(t: t)).getSolarDay().isBefore(d) {
                break
            }

            i += 1
        }
        let t: Double = ShouXingUtil.msaLonT(w: (Double(n) + Double(i) + Double([0, 90, 180, 270][index / 2]) / 360.0) * ShouXingUtil.PI_2) * 36525.0
        return JulianDay.fromJulianDay(jd + t - ShouXingUtil.dtT(t: t)).getSolarTime()
    }
    
    /// 公历时刻
    public var solarTime: SolarTime {
        let t: SolarTime = startSolarTime
        return index % 2 == 1 ? try! t.next(1) : t
    }
    
    /// 公历日
    public var solarDay: SolarDay {
        let d: SolarDay = solarTime.solarDay
        return index % 2 == 1 ? try! d.next(1) : d
    }
}
