import Foundation

/// 公历时刻
public class SolarTime: SecondUnit {
    override required init(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws {
        try Self.validate(year, month, day, hour, minute, second)
        try super.init(year, month, day, hour, minute, second)
    }

    public class func validate(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws {
        try SecondUnit.validate(hour, minute, second)
        try SolarDay.validate(year, month, day)
    }

    public class func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws -> Self {
        try Self(year, month, day, hour, minute, second)
    }

    public var solarDay: SolarDay {
        try! SolarDay.fromYmd(year, month, day)
    }

    public override func getName() -> String {
        String(format: "%02d:%02d:%02d", hour, minute, second)
    }

    public override var description: String {
        "\(solarDay) \(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        if n == 0 {
            return try Self(year, month, day, hour, minute, second)
        }
        var ts: Int = second + n
        var tm: Int = minute + ts / 60
        ts %= 60
        if ts < 0 {
            ts += 60
            tm -= 1
        }
        var th: Int = hour + tm / 60
        tm %= 60
        if tm < 0 {
            tm += 60
            th -= 1
        }
        var td: Int = th / 24
        th %= 24
        if th < 0 {
            th += 24
            td -= 1
        }

        let d: SolarDay = try solarDay.next(td)
        return try Self.fromYmdHms(d.year, d.month, d.day, th, tm, ts)
    }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromYmdHms(year, month, day, hour, minute, second)
    }

    public func isBefore(_ target: SolarTime) -> Bool {
        let aDay: SolarDay = solarDay
        let bDay: SolarDay = target.solarDay
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

    public func isAfter(_ target: SolarTime) -> Bool {
        let aDay: SolarDay = solarDay
        let bDay: SolarDay = target.solarDay
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

    public func subtract(_ target: SolarTime) -> Int {
        var days: Int = solarDay.subtract(target.solarDay)
        let cs: Int = hour * 3600 + minute * 60 + second
        let ts: Int = target.hour * 3600 + target.minute * 60 + target.second
        var seconds: Int = cs - ts
        if seconds < 0 {
            seconds += 86400
            days -= 1
        }
        seconds += days * 86400
        return seconds
    }

    /// 节气
    public var term: SolarTerm {
        var term: SolarTerm = solarDay.term
        if isBefore(term.julianDay.getSolarTime()) {
            term = term.next(-1)
        }
        return term
    }

    /// 干支时辰
    public func getSixtyCycleHour() -> SixtyCycleHour {
        try! SixtyCycleHour.fromSolarTime(self)
    }

    public func getLunarHour() -> LunarHour {
        let d: LunarDay = solarDay.getLunarDay()
        return try! LunarHour.fromYmdHms(d.year, d.month, d.day, hour, minute, second)
    }

    /// 月相
    public var phase: Phase {
        let month: LunarMonth = try! getLunarHour().lunarDay.lunarMonth.next(1)
        var p: Phase = try! Phase.fromIndex(month.year, month.monthWithLeap, 0)
        while p.solarTime.isAfter(self) {
            p = try! p.next(-1)
        }
        return p
    }

    /// 候
    public var phenology: Phenology {
        var p: Phenology = solarDay.phenology
        if isBefore(p.julianDay.getSolarTime()) {
            p = try! p.next(-1)
        }
        return p
    }
}
