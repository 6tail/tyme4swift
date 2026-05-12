import Foundation

/// 事件构建器
public class EventBuilder {
    var name: String?
    var data: [Character] = ["@", "_", "_", "_", "_", "_", "0", "0", "0"]

    public func name(_ name: String) -> Self {
        self.name = name
        return self
    }
    
    private static func getChar(_ index: Int) -> Character {
        EventManager.CHARS[index]
    }
    
    private func setValue(_ index: Int, _ n: Int) -> Self {
        data[index] = Self.getChar(31 + n)
        return self
    }

    private func content(_ type: EventType, _ a: Int, _ b: Int, _ c: Int) -> Self {
        data[1] = Self.getChar(type.getCode())
        return setValue(2, a).setValue(3, b).setValue(4, c)
    }

    public func solarDay(_ solarMonth: Int, _ solarDay: Int, _ delayDays: Int) -> Self {
        content(.SOLAR_DAY, solarMonth, solarDay, delayDays)
    }

    public func lunarDay(_ lunarMonth: Int, _ lunarDay: Int, _ delayDays: Int) -> Self {
        content(.LUNAR_DAY, lunarMonth, lunarDay, delayDays)
    }

    public func solarWeek(_ solarMonth: Int, _ weekIndex: Int, _ week: Int) -> Self {
        content(.SOLAR_WEEK, solarMonth, weekIndex, week)
    }

    public func termDay(_ termIndex: Int, _ delayDays: Int) -> Self {
        content(.TERM_DAY, termIndex, 0, delayDays)
    }

    public func termHeavenStem(_ termIndex: Int, _ heavenStemIndex: Int, _ delayDays: Int) -> Self {
        content(.TERM_HS, termIndex, heavenStemIndex, delayDays)
    }

    public func termEarthBranch(_ termIndex: Int, _ earthBranchIndex: Int, _ delayDays: Int) -> Self {
        content(.TERM_EB, termIndex, earthBranchIndex, delayDays)
    }

    public func startYear(_ year: Int) -> Self {
        let size = EventManager.CHARS.count
        var n = year
        for i in 0..<3 {
            data[8 - i] = Self.getChar(n % size)
            n /= size
        }
        return self
    }

    public func offset(_ days: Int) -> Self {
        setValue(5, days)
    }

    public func build() -> Event {
        try! Event(name ?? "", String(data))
    }
}
