import Foundation

/// 农历日
public class LunarDay: DayUnit {
    public static var NAMES: [String] = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]

    required override init(_ year: Int, _ month: Int, _ day: Int) throws {
        try Self.validate(year, month, day)
        try super.init(year, month, day)
    }
    
    public class func validate(_ year: Int, _ month: Int, _ day: Int) throws {
        if day < 1 {
            throw ArgumentError("illegal day \(day)")
        }
        let m: LunarMonth = try LunarMonth.fromYm(year, month)
        if day > m.dayCount {
            throw ArgumentError("illegal day \(day) in \(m)")
        }
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> Self {
        try Self(year, month, day)
    }
    
    /// 农历月
    public var lunarMonth: LunarMonth {
        try! LunarMonth.fromYm(year, month)
    }

    public override func getName() -> String {
        Self.NAMES[day - 1]
    }

    public override var description: String {
        "\(lunarMonth)\(getName())"
    }
    
    public override func next(_ n: Int) throws -> Self {
        if n == 0 {
            return try! Self(year, month, day)
        }
        let d: LunarDay = try getSolarDay().next(n).getLunarDay()
        return try! Self(d.year, d.month, d.day)
    }

    public func isBefore(_ target: LunarDay) -> Bool {
        if (year != target.year) {
            return year < target.year
        }
        if month != target.month {
            return abs(month) < abs(target.month)
        }
        return day < target.day
    }
    
    public func isAfter(_ target: LunarDay) -> Bool {
        if (year != target.year) {
            return year > target.year
        }
        if month != target.month {
            return abs(month) >= abs(target.month)
        }
        return day > target.day
    }

    /// 星期
    public var week: Week {
        getSolarDay().week
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        let offset: Int = Int(lunarMonth.firstJulianDay.next(day - 12).day)
        return try! SixtyCycle.fromName(HeavenStem.fromIndex(offset).getName() + EarthBranch.fromIndex(offset).getName())
    }

    /// 九星
    public var nineStar: NineStar {
        let solar: SolarDay = getSolarDay()
        let dongZhi: SolarTerm = SolarTerm.fromIndex(solar.year, 0)
        let dongZhiSolar: SolarDay = dongZhi.getSolarDay()
        let xiaZhiSolar: SolarDay = dongZhi.next(12).getSolarDay()
        let dongZhiSolar2: SolarDay = dongZhi.next(24).getSolarDay()
        let dongZhiIndex: Int = dongZhiSolar.getLunarDay().sixtyCycle.index
        let xiaZhiIndex: Int = xiaZhiSolar.getLunarDay().sixtyCycle.index
        let dongZhiIndex2: Int = dongZhiSolar2.getLunarDay().sixtyCycle.index
        var i: Int = -dongZhiIndex
        if dongZhiIndex > 29 {
            i += 60
        }
        let solarShunBai: SolarDay = try! dongZhiSolar.next(i)
        i = -dongZhiIndex2
        if dongZhiIndex2 > 29 {
            i += 60
        }
        let solarShunBai2: SolarDay = try! dongZhiSolar2.next(i)
        i = -xiaZhiIndex
        if xiaZhiIndex > 29 {
            i += 60
        }
        let solarNiZi: SolarDay = try! xiaZhiSolar.next(i)
        var offset: Int = 0
        if !solar.isBefore(solarShunBai) && solar.isBefore(solarNiZi) {
            offset = solar.subtract(solarShunBai)
        } else if !solar.isBefore(solarNiZi) && solar.isBefore(solarShunBai2) {
            offset = 8 - solar.subtract(solarNiZi)
        } else if !solar.isBefore(solarShunBai2) {
            offset = solar.subtract(solarShunBai2)
        } else if solar.isBefore(solarShunBai) {
            offset = 8 + solarShunBai.subtract(solar)
        }
        return NineStar.fromIndex(offset)
    }

    /// 建除十二值神
    public var duty: Duty {
        Duty.fromIndex(sixtyCycle.earthBranch.index - getSixtyCycleDay().month.earthBranch.index)
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(sixtyCycle.earthBranch.index + (8 - getSixtyCycleDay().month.earthBranch.index % 6) * 2)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        sixtyCycle.index % 12 < 6 ? Element.fromIndex(sixtyCycle.index / 12).getDirection() : lunarMonth.lunarYear.jupiterDirection
    }

    /// 六曜
    public var sixStar: SixStar {
        SixStar.fromIndex((lunarMonth.month + day - 2) % 6)
    }

    /// 公历日
    public func getSolarDay() -> SolarDay {
        lunarMonth.firstJulianDay.next(day - 1).getSolarDay()
    }

    /// 干支日
    public func getSixtyCycleDay() -> SixtyCycleDay {
        getSolarDay().getSixtyCycleDay()
    }

    /// 二十八宿
    public var twentyEightStar: TwentyEightStar {
        TwentyEightStar.fromIndex([10, 18, 26, 6, 14, 22, 2][getSolarDay().week.index]).next(-7 * sixtyCycle.earthBranch.index)
    }

    /// 小六壬
    public var minorRen: MinorRen {
        lunarMonth.minorRen.next(day - 1)
    }
    
    /// 当天的时辰列表
    public var hours: [LunarHour] {
        var l: [LunarHour] = [LunarHour]()
        l.append(try! LunarHour.fromYmdHms(year, month, day, 0, 0, 0))
        for i: Int in stride(from: 0, to: 24, by: 2) {
            l.append(try! LunarHour.fromYmdHms(year, month, day, i + 1, 0, 0))
        }
        return l
    }
    
    /// 逐日胎神
    public var fetusDay: FetusDay {
        FetusDay.fromLunarDay(self)
    }
    
    /// 农历传统节日，如果当天不是农历传统节日，返回null
    public var festival: LunarFestival? {
        LunarFestival.fromYmd(year, month, day)
    }
    
    /// 宜
    public var recommends: [Taboo] {
        getSixtyCycleDay().recommends
    }
    
    /// 忌
    public var avoids: [Taboo] {
        getSixtyCycleDay().avoids
    }
    
    /// 神煞列表(吉神宜趋，凶神宜忌)
    public var gods: [God] {
        getSixtyCycleDay().gods
    }
    
    /// 月相第几天
    public var phaseDay: PhaseDay {
        let today: SolarDay = getSolarDay()
        let m: LunarMonth = try! lunarMonth.next(1)
        var p: Phase = try! Phase.fromIndex(m.year, m.monthWithLeap, 0)
        var d: SolarDay = p.solarDay
        while d.isAfter(today) {
            p = try! p.next(-1)
            d = p.solarDay
        }

        return PhaseDay(p, today.subtract(d))
    }

    /// 月相
    public var phase: Phase {
        phaseDay.phase
    }
}
