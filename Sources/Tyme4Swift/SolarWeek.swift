import Foundation

/// 公历周
public class SolarWeek: WeekUnit {
    public static var NAMES: [String] = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]

    required override init(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws {
        try Self.validate(year, month, index, start)
        try super.init(year, month, index, start)
    }
    
    public class func validate(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws {
        try WeekUnit.validate(index, start)
        let m: SolarMonth = try SolarMonth.fromYm(year, month)
        if index >= m.getWeekCount(start) {
            throw ArgumentError("illegal solar week index: \(index) in month: \(m)")
        }
    }

    public class func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> Self {
        try Self(year, month, index, start)
    }
    
    public var firstDay: SolarDay {
        let firstDay: SolarDay = try! SolarDay.fromYmd(year, month, 1)
        return try! firstDay.next(index * 7 - indexOf(firstDay.week.index - start.index, 7))
    }
    
    public var indexInYear: Int {
        var i: Int = 0
        // 今年第1周
        var w: SolarWeek = try! SolarWeek.fromYm(year, 1, 0, start.index)
        while w.firstDay != firstDay {
            w = try! w.next(1)
            i += 1
        }
        return i
    }
    
    public var solarMonth: SolarMonth {
        try! SolarMonth.fromYm(year, month)
    }

    public override func getName() -> String {
        Self.NAMES[index]
    }
    
    public override var description: String {
        "\(solarMonth)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        var d: Int = index + n
        var m: SolarMonth = solarMonth
        if n > 0 {
            var weekCount: Int = m.getWeekCount(startIndex)
            while d >= weekCount {
                d -= weekCount
                m = try m.next(1)
                if m.firstDay.week.index != startIndex {
                    d += 1
                }
                weekCount = m.getWeekCount(startIndex)
            }
        } else if n < 0 {
            while d < 0 {
                if m.firstDay.week.index != startIndex {
                    d -= 1
                }
                m = try m.next(-1)
                d += m.getWeekCount(startIndex)
            }
        }
        return try Self.fromYm(m.year, m.month, d, startIndex)
    }
    
    public override func isEqual(_ t: Any?) -> Bool {
        guard let other = t as? SolarWeek else {
            return false
        }
        return firstDay == other.firstDay
    }
    
    /// 本周公历日列表
    public var days: [SolarDay] {
        var l: [SolarDay] = [SolarDay]()
        l.append(firstDay)
        for i: Int in (1..<7) {
            l.append(try! firstDay.next(i))
        }
        return l
    }
}
