import Foundation

/// 藏历日
public class RabByungDay: AbstractTyme {
    static let NAMES = [
        "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十",
    ]

    let rabByungMonth: RabByungMonth
    let isLeap: Bool
    let day: Int

    required init(month: RabByungMonth, day: Int) throws {
        if day == 0 || day < -30 || day > 30 {
            throw ArgumentError("illegal day \(day) in \(month)")
        }

        let leap = day < 0
        let d = abs(day)

        if leap && !month.leapDays.contains(d) {
            throw ArgumentError("illegal leap day \(d) in \(month)")
        }

        if !leap && month.missDays.contains(d) {
            throw ArgumentError("illegal day \(d) in \(month)")
        }
        rabByungMonth = month
        self.day = d
        isLeap = leap
    }

    required convenience init(year: Int, month: Int, day: Int) throws {
        try self.init(month: RabByungMonth.fromYm(year, month), day: day)
    }

    required convenience init(rabByungIndex: Int, element: RabByungElement, zodiac: Zodiac, month: Int, day: Int) throws {
        try self.init(month: RabByungMonth(rabByungIndex: rabByungIndex, element: element, zodiac: zodiac, month: month), day: day)
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> Self {
        try Self(year: year, month: month, day: day)
    }

    public class func fromElementZodiac(_ rabByungIndex: Int, _ element: RabByungElement, _ zodiac: Zodiac, _ month: Int, _ day: Int) throws -> Self {
        try Self(rabByungIndex: rabByungIndex, element: element, zodiac: zodiac, month: month, day: day)
    }

    static func fromSolarDay(_ solarDay: SolarDay) throws -> Self {
        var days: Int = solarDay.subtract(try! SolarDay.fromYmd(1951, 1, 8))
        var m: RabByungMonth = try! RabByungMonth.fromYm(1950, 12)
        var count: Int = m.dayCount

        while days >= count {
            days -= count
            m = try m.next(1)
            count = m.dayCount
        }

        var day: Int = days + 1
        for d in m.specialDays {
            if d < 0 {
                if day >= -d {
                    day += 1
                }
            } else if d > 0 {
                if day == d + 1 {
                    day = -d
                    break
                }

                if day > d + 1 {
                    day -= 1
                }
            }
        }

        return try Self(month: m, day: day)
    }

    public var year: Int {
        rabByungMonth.year
    }

    public var month: Int {
        rabByungMonth.monthWithLeap
    }

    public var dayWithLeap: Int {
        isLeap ? -day : day
    }

    override public func getName() -> String {
        (isLeap ? "闰" : "") + Self.NAMES[day - 1]
    }

    override public var description: String {
        "\(rabByungMonth)\(getName())"
    }

    public func getSolarDay() -> SolarDay {
        var m: RabByungMonth = try! RabByungMonth.fromYm(1950, 12)
        var n: Int = 0

        while !rabByungMonth.isEqual(m) {
            n += m.dayCount
            m = try! m.next(1)
        }

        var t: Int = day
        for d in m.specialDays {
            if d < 0 {
                if t > -d {
                    t -= 1
                }
            } else if d > 0 {
                if t > d {
                    t += 1
                }
            }
        }

        if isLeap {
            t += 1
        }

        return try! SolarDay.fromYmd(1951, 1, 7).next(n + t)
    }

    override public func next(_ n: Int) throws -> Self {
        let d: RabByungDay = try getSolarDay().next(n).getRabByungDay()
        return try Self(month: d.rabByungMonth, day: d.day)
    }
}
