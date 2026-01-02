import Foundation

/// 农历周
public class LunarWeek: WeekUnit {
    public static var NAMES: [String] = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]

    required override init(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws {
        try Self.validate(year, month, index, start)
        try super.init(year, month, index, start)
    }
    
    public class func validate(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws {
        try WeekUnit.validate(index, start)
        let m: LunarMonth = try LunarMonth.fromYm(year, month)
        if index >= m.getWeekCount(start) {
            throw ArgumentError("illegal lunar week index: \(index) in month: \(m)")
        }
    }

    public class func fromYm(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws -> Self {
        try Self(year, month, index, start)
    }
    
    /// 农历月
    public var lunarMonth: LunarMonth {
        try! LunarMonth.fromYm(year, month)
    }
    
    /// 本周第1天
    public var firstDay: LunarDay {
        let firstDay: LunarDay = try! LunarDay.fromYmd(year, month, 1)
        return try! firstDay.next(index * 7 - indexOf(firstDay.week.index - start.index, 7))
    }

    public override func getName() -> String {
        Self.NAMES[index]
    }
    
    public override var description: String {
        "\(lunarMonth)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        var d: Int = index
        var m: LunarMonth = lunarMonth
        if n > 0 {
            d += n
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
            d += n
            while d < 0 {
                if m.firstDay.week.index != startIndex {
                    d -= 1
                }
                m = try m.next(-1)
                d += m.getWeekCount(startIndex)
            }
        }
        return try Self.fromYm(m.year, m.monthWithLeap, d, startIndex)
    }
    
    public override func isEqual(_ t: Any?) -> Bool {
        guard let other = t as? LunarWeek else {
            return false
        }
        return firstDay == other.firstDay
    }
    
    /// 本周公历日列表
    public var days: [LunarDay] {
        var l: [LunarDay] = [LunarDay]()
        l.append(firstDay)
        for i: Int in (1..<7) {
            l.append(try! firstDay.next(i))
        }
        return l
    }
}
