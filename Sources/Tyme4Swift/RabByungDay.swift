import Foundation

/// 藏历日
public class RabByungDay: DayUnit {
    static let NAMES = [
        "初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十",
    ]

    let isLeap: Bool
    
    public class func validate(_ year: Int, _ month: Int, _ day: Int) throws {
        if day == 0 || day < -30 || day > 30 {
            throw ArgumentError("illegal day \(day) in \(month)")
        }
        let m: RabByungMonth = try! RabByungMonth.fromYm(year, month)
        let leap: Bool = day < 0
        let d: Int = abs(day)

        if leap && !m.leapDays.contains(d) {
            throw ArgumentError("illegal leap day \(d) in \(m)")
        }

        if !leap && m.missDays.contains(d) {
            throw ArgumentError("illegal day \(d) in \(m)")
        }
    }
    
    required override init(_ year: Int, _ month: Int, _ day: Int) throws {
        try Self.validate(year, month, day)
        isLeap = day < 0
        try super.init(year, month, abs(day))
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> Self {
        try Self(year, month, day)
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

        return try Self(m.year, m.monthWithLeap, day)
    }
    
    public var rabByungMonth: RabByungMonth {
        try! RabByungMonth.fromYm(year, month)
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
        let cm: RabByungMonth = rabByungMonth
        var n: Int = 0

        while !m.isEqual(cm) {
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
        return try Self(d.year, d.month, d.dayWithLeap)
    }
}
