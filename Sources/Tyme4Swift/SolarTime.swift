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
        let t: Int = getSecondsInDay() + n
        let s: Int = indexOf(t, 86400)
        let d: SolarDay = try solarDay.next(floorDiv(t, 86400))
        return try Self.fromYmdHms(d.year, d.month, d.day, s / 3600, s % 3600 / 60, s % 60)
    }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromYmdHms(year, month, day, hour, minute, second)
    }

    public func isBefore(_ target: SolarTime) -> Bool {
        getCompareIndex() < target.getCompareIndex()
    }

    public func isAfter(_ target: SolarTime) -> Bool {
        getCompareIndex() > target.getCompareIndex()
    }

    public func subtract(_ target: SolarTime) -> Int {
        solarDay.subtract(target.solarDay) * 86400 + getSecondsInDay() - target.getSecondsInDay()
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
