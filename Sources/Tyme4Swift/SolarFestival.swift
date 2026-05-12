import Foundation

/// 公历现代节日
public class SolarFestival: AbstractFestival {
    public static var NAMES: [String] = ["元旦", "妇女节", "植树节", "劳动节", "青年节", "儿童节", "建党节", "建军节", "教师节", "国庆节"]
    public static var DATA: String = "0VV__0Ux0Xc__0Ux0Xg__0_Q0ZV__0Ux0ZY__0Ux0aV__0Ux0bV__0Uo0cV__0Ug0de__0_V0eV__0Ux"

    required init(_ index: Int, _ event: Event, _ day: SolarDay) {
        super.init(index, event, day)
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> Self? {
        let d = try! SolarDay.fromYmd(year, month, day)
        for i in 0..<NAMES.count {
            let start = i * 8
            let e = try! Event(NAMES[i], "@" + String(DATA[DATA.index(DATA.startIndex, offsetBy: start)..<DATA.index(DATA.startIndex, offsetBy: start+8)]))
            if d.year >= e.startYear && d.month == e.getValue(2) && d.day == e.getValue(3) {
                return Self(i, e, d)
            }
        }
        return nil
    }

    public class func fromIndex(_ year: Int, _ index: Int) -> Self? {
        guard index >= 0 && index < NAMES.count else { return nil }
        let start = index * 8
        let e = try! Event(NAMES[index], "@" + String(DATA[DATA.index(DATA.startIndex, offsetBy: start)..<DATA.index(DATA.startIndex, offsetBy: start+8)]))
        guard year >= e.startYear else { return nil }
        return Self(index, e, try! SolarDay.fromYmd(year, e.getValue(2), e.getValue(3)))
    }

    public override func next(_ n: Int) -> Self? {
        let size: Int = Self.NAMES.count
        let i: Int = index + n
        return Self.fromIndex((day.year * size + i) / size, indexOf(i, size))
    }
    
    /// 起始年
    var startYear: Int { event.startYear }

    /// 公历日
    public override func getDay() -> SolarDay {
        day as! SolarDay
    }
}
