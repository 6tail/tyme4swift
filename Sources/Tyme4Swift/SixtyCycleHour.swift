import Foundation

/// 干支时辰（立春换年，节令换月，23点换日）
public class SixtyCycleHour: AbstractTyme {
    /// 公历时刻
    public private(set) var solarTime: SolarTime
    /// 干支日
    public private(set) var sixtyCycleDay: SixtyCycleDay
    /// 时柱
    public private(set) var hour: SixtyCycle

    required init(_ solarTime: SolarTime, _ sixtyCycleDay: SixtyCycleDay, _ hour: SixtyCycle) {
        self.solarTime = solarTime
        self.sixtyCycleDay = sixtyCycleDay
        self.hour = hour
    }

    public class func fromSolarTime(_ solarTime: SolarTime) throws -> Self {
        let solarYear: Int = solarTime.year
        let springSolarTime: SolarTime = SolarTerm.fromIndex(solarYear, 3).julianDay.getSolarTime()
        let lunarHour: LunarHour = solarTime.getLunarHour()
        let lunarDay: LunarDay = lunarHour.lunarDay
        var lunarYear: LunarYear = lunarDay.lunarMonth.lunarYear
        if lunarYear.year == solarYear {
            if solarTime.isBefore(springSolarTime) {
                lunarYear = try lunarYear.next(-1)
            }
        } else if lunarYear.year < solarYear {
            if !solarTime.isBefore(springSolarTime) {
                lunarYear = try lunarYear.next(1)
            }
        }

        let term: SolarTerm = solarTime.term
        var index: Int = term.index - 3
        if index < 0 && term.julianDay.getSolarTime().isAfter(SolarTerm.fromIndex(solarYear, 3).julianDay.getSolarTime()) {
            index += 24
        }
        let d: SixtyCycle = lunarDay.sixtyCycle
        return Self(solarTime, SixtyCycleDay(solarTime.solarDay, SixtyCycleMonth(try! SixtyCycleYear.fromYear(lunarYear.year), try! LunarMonth.fromYm(solarYear, 1).sixtyCycle.next(Int(floor(Double(index) * 0.5)))), solarTime.hour < 23 ? d : d.next(1)), lunarHour.sixtyCycle)
    }

    public override func getName() -> String {
        "\(hour)时"
    }

    public override var description: String {
        "\(day)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        try Self.fromSolarTime(solarTime.next(n))
    }

    public var year: SixtyCycle {
        sixtyCycleDay.year
    }

    public var month: SixtyCycle {
        sixtyCycleDay.month
    }

    public var day: SixtyCycle {
        sixtyCycleDay.sixtyCycle
    }

    public var sixtyCycle: SixtyCycle {
        hour
    }

    public var indexInDay: Int {
        solarTime.hour == 23 ? 0 : (solarTime.hour + 1) / 2
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(hour.earthBranch.index + (8 - day.earthBranch.index % 6) * 2)
    }

    /// 九星
    public var nineStar: NineStar {
        let solar: SolarDay = solarTime.solarDay
        let dongZhi: SolarTerm = SolarTerm.fromIndex(solar.year, 0)
        let earthBranchIndex: Int = indexInDay % 12
        var index: Int = [8, 5, 2 ][day.earthBranch.index % 3]
        if (!solar.isBefore(dongZhi.julianDay.getSolarDay()) && solar.isBefore(dongZhi.next(12).julianDay.getSolarDay())) {
            index = 8 + earthBranchIndex - index
        } else {
            index -= earthBranchIndex
        }
        return NineStar.fromIndex(index)
    }
    
    /// 宜
    public var recommends: [Taboo] {
        Taboo.getHourRecommends(day, sixtyCycle)
    }
    
    /// 忌
    public var avoids: [Taboo] {
        Taboo.getHourAvoids(day, sixtyCycle)
    }
}
