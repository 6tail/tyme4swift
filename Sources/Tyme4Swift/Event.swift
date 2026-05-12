import Foundation

/// 事件
public class Event: AbstractCulture {
    let name: String
    let data: String

    init(_ name: String, _ data: String) throws {
        try Event.validate(data)
        self.name = name
        self.data = data
    }

    public static func validate(_ data: String) throws {
        if data.count != 9 {
            throw ArgumentError("illegal event data: \(data)")
        }
    }

    public static func builder() -> EventBuilder {
        EventBuilder()
    }

    public static func fromName(_ name: String) -> Event? {
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: EventManager.formatRegex(name)) else { return nil }
        let s: NSString = EventManager.DATA as NSString
        if let match = regex.firstMatch(in: EventManager.DATA, range: NSRange(location: 0, length: s.length)) {
            let data = s.substring(with: match.range(at: 1))
            return try? Event(name, data)
        }
        return nil
    }
    
    private func getCharIndex(_ index: Int) -> Int {
        EventManager.CHARS.firstIndex(of: data[data.index(data.startIndex, offsetBy: index)]) ?? 0
    }

    func getValue(_ index: Int) -> Int {
        return getCharIndex(index) - 31
    }

    func getMonth(_ year: Int) -> [Int] {
        var y = year
        var m = getValue(2)
        if m > 12 {
            m = 1
            y += 1
        }
        return [y, m]
    }

    public var type: EventType? {
        EventType.fromCode(getCharIndex(1))
    }

    public var startYear: Int {
        var n: Int = 0
        let size: Int = EventManager.CHARS.count
        for i in 0..<3 {
            n = n * size + getCharIndex(6 + i)
        }
        return n
    }

    public static func fromSolarDay(_ d: SolarDay) -> [Event] {
        all().filter { d == $0.getSolarDay(d.year) }
    }

    public static func all() -> [Event] {
        var events: [Event] = []
        guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: EventManager.formatRegex(".[^@]+")) else { return events }
        let s: NSString = EventManager.DATA as NSString
        regex.enumerateMatches(in: EventManager.DATA, range: NSRange(location: 0, length: s.length)) { match, _, _ in
            if let match = match {
                events.append(try! Event(s.substring(with: match.range(at: 2)), s.substring(with: match.range(at: 1))))
            }
        }
        return events
    }

    public func getSolarDay(_ year: Int) -> SolarDay? {
        guard let t = type else { return nil }
        if year < startYear { return nil }

        var d: SolarDay?
        switch t {
        case .SOLAR_DAY:
            d = getSolarDayBySolarDay(year)
        case .SOLAR_WEEK:
            d = getSolarDayByWeek(year)
        case .LUNAR_DAY:
            d = getSolarDayByLunarDay(year)
        case .TERM_DAY:
            d = getSolarDayByTerm(year)
        case .TERM_HS:
            d = getSolarDayByTermHeavenStem(year)
        case .TERM_EB:
            d = getSolarDayByTermEarthBranch(year)
        }

        guard let d = d else { return nil }
        let offset: Int = getValue(5)
        return offset == 0 ? d : try? d.next(offset)
    }

    private func getSolarDayBySolarDay(_ year: Int) -> SolarDay? {
        let month = getMonth(year)
        let y = month[0]
        let m = month[1]
        let d = getValue(3)
        let delay = getValue(4)
        let lastDay: Int = try! SolarMonth.fromYm(y, m).dayCount
        if d > lastDay {
            if delay == 0 { return nil }
            if delay < 0 {
                return try? SolarDay.fromYmd(y, m, d + delay)
            }
            return try? SolarDay.fromYmd(y, m, lastDay).next(delay)
        }
        return try? SolarDay.fromYmd(y, m, d)
    }

    private func getSolarDayByLunarDay(_ year: Int) -> SolarDay? {
        let month = getMonth(year)
        let y = month[0]
        let m = month[1]
        let d = getValue(3)
        let delay = getValue(4)
        let lastDay: Int = try! LunarMonth.fromYm(y, m).dayCount
        if d > lastDay {
            if delay == 0 { return nil }
            if delay < 0 {
                return try? LunarDay.fromYmd(y, m, d + delay).getSolarDay()
            }
            return try? LunarDay.fromYmd(y, m, lastDay).getSolarDay().next(delay)
        }
        return try? LunarDay.fromYmd(y, m, d).getSolarDay()
    }

    private func getSolarDayByWeek(_ year: Int) -> SolarDay? {
        // 第几个星期
        let n: Int = getValue(3)
        if n == 0 { return nil }
        let month: SolarMonth = try! SolarMonth.fromYm(year, getValue(2))
        // 星期几，0-6
        let w: Int = getValue(4)
        if n > 0 {
            let first: SolarDay = month.firstDay
            return try? first.next(first.week.stepsTo(w) + 7 * n - 7)
        } else {
            let last: SolarDay = try! SolarDay.fromYmd(year, month.month, month.dayCount)
            return try? last.next(last.week.stepsBackTo(w) + 7 * n + 7)
        }
    }

    private func getSolarDayByTerm(_ year: Int) -> SolarDay? {
        let d: SolarDay = SolarTerm.fromIndex(year, getValue(2)).getSolarDay()
        let offset: Int = getValue(4)
        return offset == 0 ? d : try? d.next(offset)
    }

    private func getSolarDayByTermHeavenStem(_ year: Int) -> SolarDay? {
        guard let d = getSolarDayByTerm(year) else { return nil }
        return try? d.next(d.getLunarDay().sixtyCycle.heavenStem.stepsTo(getValue(3)))
    }

    private func getSolarDayByTermEarthBranch(_ year: Int) -> SolarDay? {
        guard let d = getSolarDayByTerm(year) else { return nil }
        return try? d.next(d.getLunarDay().sixtyCycle.earthBranch.stepsTo(getValue(3)))
    }
    
    public override func getName() -> String {
        name
    }
}
