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

    public var type: EventType? {
        guard data.count > 1 else { return nil }
        if let idx = EventManager.CHARS.firstIndex(of: data[data.index(data.startIndex, offsetBy: 1)]) {
            return EventType.fromCode(EventManager.CHARS.distance(from: EventManager.CHARS.startIndex, to: idx))
        }
        return nil
    }

    public var startYear: Int {
        var n: Int = 0
        let size: Int = EventManager.CHARS.count
        for i in 0..<3 {
            if let idx = EventManager.CHARS.firstIndex(of: data[data.index(data.startIndex, offsetBy: 6 + i)]) {
                let pos = EventManager.CHARS.distance(from: EventManager.CHARS.startIndex, to: idx)
                n = n * size + pos
            }
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
        let offset: Int = getOffset()
        return offset == 0 ? d : try? d.next(offset)
    }

    private func getValue(at index: Int) -> Int {
        if let idx = EventManager.CHARS.firstIndex(of: data[data.index(data.startIndex, offsetBy: index)]) {
            return EventManager.CHARS.distance(from: EventManager.CHARS.startIndex, to: idx)
        }
        return 0
    }

    private func getOffset() -> Int {
        getValue(at: 5) - 31
    }

    private func getSolarDayBySolarDay(_ year: Int) -> SolarDay? {
        var y: Int = year
        var m: Int = getValue(at: 2) - 31
        if m > 12 {
            m = 1
            y += 1
        }
        let d: Int = getValue(at: 3) - 31
        let delay: Int = getValue(at: 4) - 31
        let month: SolarMonth = try! SolarMonth.fromYm(y, m)
        let lastDay: Int = month.dayCount
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
        var y: Int = year
        var m: Int = getValue(at: 2) - 31
        if m > 12 {
            m = 1
            y += 1
        }
        let d: Int = getValue(at: 3) - 31
        let delay: Int = getValue(at: 4) - 31
        let month: LunarMonth = try! LunarMonth.fromYm(y, m)
        let lastDay: Int = month.dayCount
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
        let n: Int = getValue(at: 3) - 31
        if n == 0 { return nil }
        let month: SolarMonth = try! SolarMonth.fromYm(year, getValue(at: 2) - 31)
        let w: Int = getValue(at: 4) - 31
        if n > 0 {
            let first: SolarDay = month.firstDay
            return try? first.next(first.week.stepsTo(w) + 7 * n - 7)
        } else {
            let last: SolarDay = try! SolarDay.fromYmd(year, month.month, month.dayCount)
            return try? last.next(last.week.stepsBackTo(w) + 7 * n + 7)
        }
    }

    private func getSolarDayByTerm(_ year: Int) -> SolarDay? {
        let offset: Int = getValue(at: 4) - 31
        let d: SolarDay = SolarTerm.fromIndex(year, getValue(at: 2) - 31).getSolarDay()
        return offset == 0 ? d : try? d.next(offset)
    }

    private func getSolarDayByTermHeavenStem(_ year: Int) -> SolarDay? {
        guard let d = getSolarDayByTerm(year) else { return nil }
        return try? d.next(d.getLunarDay().sixtyCycle.heavenStem.stepsTo(getValue(at: 3) - 31))
    }

    private func getSolarDayByTermEarthBranch(_ year: Int) -> SolarDay? {
        guard let d = getSolarDayByTerm(year) else { return nil }
        return try? d.next(d.getLunarDay().sixtyCycle.earthBranch.stepsTo(getValue(at: 3) - 31))
    }
}
