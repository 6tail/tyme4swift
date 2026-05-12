import Foundation

/// 农历传统节日（依据国家标准《农历的编算和颁行》GB/T 33661-2017）
public class LunarFestival: AbstractFestival {
    public static var NAMES: [String] = ["春节", "元宵节", "龙头节", "上巳节", "清明节", "端午节", "七夕节", "中元节", "中秋节", "重阳节", "冬至节", "腊八节", "除夕"]
    public static var DATA: String = "2VV__0002Vj__0002WW__0002XX__0003b___0002ZZ__0002bb__0002bj__0002cj__0002dd__0003s___0002gc__0002hV_U000"

    required init(_ index: Int, _ event: Event, _ day: LunarDay) {
        super.init(index, event, day)
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> Self? {
        let d = try! LunarDay.fromYmd(year, month, day)
        for i in 0..<NAMES.count {
            let start = i * 8
            let e = try! Event(NAMES[i], "@" + String(DATA[DATA.index(DATA.startIndex, offsetBy: start)..<DATA.index(DATA.startIndex, offsetBy: start+8)]))
            switch e.type {
            case .LUNAR_DAY:
                let offset = e.getValue(5)
                if offset == 0 {
                    if d.month == e.getValue(2) && d.day == e.getValue(3) {
                        return Self(i, e, d)
                    }
                } else {
                    let m = e.getMonth(d.year)
                    let next = try! d.next(-offset)
                    if next.year == m[0] && next.month == m[1] && next.day == e.getValue(3) {
                        return Self(i, e, d)
                    }
                }
            case .TERM_DAY:
                let term = d.getSolarDay().termDay
                if term.dayIndex == 0 && term.solarTerm.index == e.getValue(2) % 24 {
                    return Self(i, e, d)
                }
            default:
                break
            }
        }
        return nil
    }

    public class func fromIndex(_ year: Int, _ index: Int) -> Self? {
        guard index >= 0 && index < NAMES.count else { return nil }
        let start = index * 8
        let e = try! Event(NAMES[index], "@" + String(DATA[DATA.index(DATA.startIndex, offsetBy: start)..<DATA.index(DATA.startIndex, offsetBy: start+8)]))
        switch e.type {
        case .LUNAR_DAY:
            let m = e.getMonth(year)
            let d = try! LunarDay.fromYmd(m[0], m[1], e.getValue(3))
            let offset = e.getValue(5)
            return Self(index, e, offset == 0 ? d : try! d.next(offset))
        case .TERM_DAY:
            return Self(index, e, SolarTerm.fromIndex(year, e.getValue(2)).getSolarDay().getLunarDay())
        default:
            return nil
        }
    }

    public override func next(_ n: Int) -> Self? {
        let size: Int = Self.NAMES.count
        let i: Int = index + n
        return Self.fromIndex((day.year * size + i) / size, indexOf(i, size))
    }

    /// 农历日
    public override func getDay() -> LunarDay {
        day as! LunarDay
    }
    
    /// 节气，非节气当天返回 nil
    var solarTerm: SolarTerm? {
        let t = getDay().getSolarDay().termDay
        return t.dayIndex == 0 ? t.solarTerm : nil
    }
}
