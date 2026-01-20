import Foundation

/// 干支日（立春换年，节令换月）
public class SixtyCycleDay: AbstractTyme {
    /// 公历日
    public private(set) var solarDay: SolarDay
    /// 干支月
    public private(set) var sixtyCycleMonth: SixtyCycleMonth
    /// 日柱
    public private(set) var day: SixtyCycle

    required init(_ solarDay: SolarDay, _ month: SixtyCycleMonth, _ day: SixtyCycle) {
        self.solarDay = solarDay
        self.sixtyCycleMonth = month
        self.day = day
    }

    public class func fromSolarDay(_ solarDay: SolarDay) throws -> Self {
        let term: SolarTerm = solarDay.term
        let index: Int = term.index
        var offset: Int = -1
        if index < 3 {
            if index == 0 {
                offset = -2
            }
        } else {
            offset = (index - 3) / 2
        }
        return Self(solarDay, try SixtyCycleYear.fromYear(term.year).firstMonth.next(offset), SixtyCycle.fromIndex(solarDay.subtract(try SolarDay.fromYmd(2000, 1, 7))))
    }

    public override func getName() -> String {
        "\(day)日"
    }

    public override var description: String {
        "\(sixtyCycleMonth)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        try Self.fromSolarDay(solarDay.next(n))
    }

    public var year: SixtyCycle {
        sixtyCycleMonth.year
    }

    public var month: SixtyCycle {
        sixtyCycleMonth.sixtyCycle
    }

    public var sixtyCycle: SixtyCycle {
        day
    }

    /// 建除十二值神
    public var duty: Duty {
        Duty.fromIndex(day.earthBranch.index - month.earthBranch.index)
    }

    /// 黄道黑道十二神
    public var twelveStar: TwelveStar {
        TwelveStar.fromIndex(day.earthBranch.index + (8 - month.earthBranch.index % 6) * 2)
    }

    /// 九星
    public var nineStar: NineStar {
        let dongZhi: SolarTerm = SolarTerm.fromIndex(solarDay.year, 0)
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
        if !solarDay.isBefore(solarShunBai) && solarDay.isBefore(solarNiZi) {
            offset = solarDay.subtract(solarShunBai)
        } else if !solarDay.isBefore(solarNiZi) && solarDay.isBefore(solarShunBai2) {
            offset = 8 - solarDay.subtract(solarNiZi)
        } else if !solarDay.isBefore(solarShunBai2) {
            offset = solarDay.subtract(solarShunBai2)
        } else if solarDay.isBefore(solarShunBai) {
            offset = 8 + solarShunBai.subtract(solarDay)
        }
        return NineStar.fromIndex(offset)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        sixtyCycle.index % 12 < 6 ? Element.fromIndex(sixtyCycle.index / 12).getDirection() : sixtyCycleMonth.sixtyCycleYear.jupiterDirection
    }

    /// 二十八宿
    public var twentyEightStar: TwentyEightStar {
        TwentyEightStar.fromIndex([10, 18, 26, 6, 14, 22, 2][solarDay.week.index]).next(-7 * day.earthBranch.index)
    }
    
    /// 三柱
    public var threePillars: ThreePillars {
        ThreePillars(year, month, sixtyCycle)
    }
    
    /// 宜
    public var recommends: [Taboo] {
        Taboo.getDayRecommends(month, sixtyCycle)
    }
    
    /// 忌
    public var avoids: [Taboo] {
        Taboo.getDayAvoids(month, sixtyCycle)
    }
    
    /// 神煞列表(吉神宜趋，凶神宜忌)
    public var gods: [God] {
        God.getDayGods(month, sixtyCycle)
    }
}
