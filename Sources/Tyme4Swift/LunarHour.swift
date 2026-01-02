import Foundation

/// 农历时辰
public class LunarHour: SecondUnit {

    required override init(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws {
        try Self.validate(year, month, day, hour, minute, second)
        try super.init(year, month, day, hour, minute, second)
    }
    
    public class func validate(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws {
        try SecondUnit.validate(hour, minute, second)
        try LunarDay.validate(year, month, day)
    }

    public class func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> Self {
        try Self(year, month, day, hour, minute, second)
    }
    
    public var lunarDay: LunarDay {
        try! LunarDay.fromYmd(year, month, day)
    }

    public override func getName() -> String {
        "\(EarthBranch.fromIndex(indexInDay).getName())时"
    }

    public override var description: String {
        "\(lunarDay)\(sixtyCycle.getName())时"
    }

    public override func next(_ n: Int) throws -> Self {
        if n == 0 {
            return try! Self.fromYmdHms(year, month, day, hour, minute, second)
        }

        let h: Int = hour + n * 2
        let diff: Int = h < 0 ? -1 : 1
        var hour: Int = abs(h)
        var days: Int = hour / 24 * diff
        hour = (hour % 24) * diff
        if hour < 0 {
            hour += 24
            days -= 1
        }

        let d: LunarDay = try lunarDay.next(days)
        return try! Self.fromYmdHms(d.year, d.month, d.day, hour, minute, second)
    }

    public var sixtyCycle: SixtyCycle {
        let earthBranchIndex: Int = indexInDay % 12
        var d: SixtyCycle = lunarDay.sixtyCycle
        if hour >= 23 {
            d = d.next(1)
        }
        return try! SixtyCycle.fromName(HeavenStem.fromIndex(d.heavenStem.index % 5 * 2 + earthBranchIndex).getName() + EarthBranch.fromIndex(earthBranchIndex).getName())
    }

    public var indexInDay: Int {
        (hour + 1) / 2
    }

    public func isBefore(_ target: LunarHour) -> Bool {
        let aDay: LunarDay = lunarDay
        let bDay: LunarDay = target.lunarDay
        if aDay != bDay {
            return aDay.isBefore(bDay)
        }
        let aHour: Int = hour
        let bHour: Int = target.hour
        if aHour != bHour {
            return aHour < bHour
        }
        let aMinute: Int = minute
        let bMinute: Int = target.minute
        return aMinute != bMinute ? aMinute < bMinute : second < target.second
    }
    
    public func isAfter(_ target: LunarHour) -> Bool {
        let aDay: LunarDay = lunarDay
        let bDay: LunarDay = target.lunarDay
        if aDay != bDay {
            return aDay.isAfter(bDay)
        }
        let aHour: Int = hour
        let bHour: Int = target.hour
        if aHour != bHour {
            return aHour > bHour
        }
        let aMinute: Int = minute
        let bMinute: Int = target.minute
        return aMinute != bMinute ? aMinute > bMinute : second > target.second
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(sixtyCycle.earthBranch.index + (8 - getSixtyCycleHour().day.earthBranch.index % 6) * 2)
    }

    /// 九星
    public var nineStar: NineStar {
        let solar: SolarDay = lunarDay.getSolarDay()
        let dongZhi: SolarTerm = SolarTerm.fromIndex(solar.year, 0)
        let earthBranchIndex: Int = indexInDay % 12
        var index: Int = [8, 5, 2 ][lunarDay.sixtyCycle.earthBranch.index % 3]
        if !solar.isBefore(dongZhi.julianDay.getSolarDay()) && solar.isBefore(dongZhi.next(12).julianDay.getSolarDay()) {
            index = 8 + earthBranchIndex - index
        } else {
            index -= earthBranchIndex
        }
        return NineStar.fromIndex(index)
    }

    /// 公历时刻
    public func getSolarTime() -> SolarTime {
        let d: SolarDay = lunarDay.getSolarDay()
        return try! SolarTime.fromYmdHms(d.year, d.month, d.day, hour, minute, second)
    }

    /// 干支时辰
    public func getSixtyCycleHour() -> SixtyCycleHour {
        return getSolarTime().getSixtyCycleHour()
    }

    /// 小六壬
    public var minorRen: MinorRen {
        lunarDay.minorRen.next(indexInDay)
    }
    
    /// 宜
    public var recommends: [Taboo] {
        getSixtyCycleHour().recommends
    }
    
    /// 忌
    public var avoids: [Taboo] {
        getSixtyCycleHour().avoids
    }
}
