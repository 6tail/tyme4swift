import Foundation

/// 农历月
public class LunarMonth: MonthUnit {
    public static var NAMES: [String] = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
    
    /// 是否闰月
    public private(set) var isLeap: Bool

    required override init(_ year: Int, _ month: Int) throws {
        try Self.validate(year, month)
        isLeap = month < 0
        try super.init(year, abs(month))
    }
    
    public class func validate(_ year: Int, _ month: Int) throws {
        if month == 0 || month > 12 || month < -12 {
            throw ArgumentError("illegal lunar month: \(month)")
        }
        if month < 0 {
            let y: LunarYear = try LunarYear.fromYear(year)
            if -month != y.leapMonth {
                throw ArgumentError("illegal leap month \(month) in lunar year \(year)")
            }
        }
    }

    public class func fromYm(_ year: Int, _ month: Int) throws -> Self {
        try Self(year, month)
    }
    
    func getNewMoon() -> Double {
        // 冬至
        let dongZhiJd: Double = SolarTerm.fromIndex(year, 0).cursoryJulianDay

        // 冬至前的初一，今年首朔的日月黄经差
        var w: Double = ShouXingUtil.calcShuo(dongZhiJd)
        if w > dongZhiJd {
            w -= 29.53
        }

        // 正常情况正月初一为第3个朔日，但有些特殊的
        var offset: Int = 2
        if year > 8 && year < 24 {
            offset = 1
        } else if try! LunarYear.fromYear(year - 1).leapMonth > 10 && year != 239 && year != 240 {
            offset = 3
        }
        
        // 本月初一
        return w + 29.5306 * Double(offset + indexInYear)
    }
    
    /// 农历年
    public var lunarYear: LunarYear {
        try! LunarYear.fromYear(year)
    }
    
    /// 位于当年的索引(0-12)
    public var indexInYear: Int {
        var index: Int = month - 1
        if isLeap {
            index += 1
        } else {
            let leapMonth: Int = try! LunarYear.fromYear(year).leapMonth
            if leapMonth > 0 && month > leapMonth {
                index += 1
            }
        }
        return index
    }

    /// 月，当月为闰月时，返回负数
    public var monthWithLeap: Int {
        isLeap ? -month : month
    }

    public override func getName() -> String {
        "\(isLeap ? "闰" : "")\(Self.NAMES[month - 1])"
    }

    public override var description: String {
        "\(lunarYear)\(getName())"
    }
    
    public override func next(_ n: Int) throws -> Self {
        if n == 0 {
            return try! Self.fromYm(year, monthWithLeap)
        }

        var m: Int = indexInYear + 1 + n
        var y: LunarYear = lunarYear
        if n > 0 {
            while m > y.monthCount {
                m -= y.monthCount
                y = try y.next(1)
            }
        } else {
            while m <= 0 {
                y = try y.next(-1)
                m += y.monthCount
            }
        }

        var leap: Bool = false
        let leapMonth: Int = y.leapMonth
        if leapMonth > 0 {
            if m == leapMonth + 1 {
                leap = true
            }

            if m > leapMonth {
                m -= 1
            }
        }

        return try Self.fromYm(y.year, leap ? -m : m)
    }
    
    /// 初一的儒略日
    public var firstJulianDay: JulianDay {
        JulianDay.fromJulianDay(JulianDay.J2000 + ShouXingUtil.calcShuo(getNewMoon()))
    }
    
    /// 初一的农历日
    public var firstDay: LunarDay {
        try! LunarDay.fromYmd(year, monthWithLeap, 1)
    }

    /// 农历季节
    public var season: LunarSeason {
        LunarSeason.fromIndex(month - 1)
    }
    
    /// 天数(大月30天，小月29天)
    public var dayCount: Int {
        let w: Double = getNewMoon()
        // 本月天数 = 下月初一 - 本月初一
        return Int(ShouXingUtil.calcShuo(w + 29.5306) - ShouXingUtil.calcShuo(w))
    }
    
    /// 本月的农历日列表
    public var days: [LunarDay] {
        var l: [LunarDay] = [LunarDay]()
        for i: Int in (1...dayCount) {
            l.append(try! LunarDay.fromYmd(year, monthWithLeap, i))
        }
        return l
    }

    public func getWeekCount(_ start: Int) -> Int {
        Int(ceil(Double(indexOf(firstJulianDay.week.index - start, 7) + dayCount) / 7.0))
    }
    
    /// 本月的农历周列表
    public func getWeeks(_ start: Int) -> [LunarWeek] {
        var l: [LunarWeek] = [LunarWeek]()
        let size: Int = getWeekCount(start)
        for i: Int in (1..<size) {
            l.append(try! LunarWeek.fromYm(year, monthWithLeap, i, start))
        }
        return l
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        try! SixtyCycle.fromName(HeavenStem.fromIndex(lunarYear.sixtyCycle.heavenStem.index * 2 + month + 1).getName() + EarthBranch.fromIndex(month + 1).getName())
    }

    /// 九星
    public var nineStar: NineStar {
        var index: Int = sixtyCycle.earthBranch.index
        if index < 2 {
            index += 3
        }
        return NineStar.fromIndex(27 - lunarYear.sixtyCycle.earthBranch.index % 3 * 3 - index)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let n: Int = [7, -1, 1, 3 ][sixtyCycle.earthBranch.next(-2).index % 4]
        return n != -1 ? Direction.fromIndex(n) : sixtyCycle.heavenStem.direction
    }

    /// 小六壬
    public var minorRen: MinorRen {
        MinorRen.fromIndex((month - 1) % 6)
    }
    
    /// 逐月胎神
    public var fetus: FetusMonth? {
        FetusMonth.fromLunarMonth(self)
    }
}
