import Foundation

/// 公历日
public class SolarDay: DayUnit {
    public static var NAMES: [String] = ["1日", "2日", "3日", "4日", "5日", "6日", "7日", "8日", "9日", "10日", "11日", "12日", "13日", "14日", "15日", "16日", "17日", "18日", "19日", "20日", "21日", "22日", "23日", "24日", "25日", "26日", "27日", "28日", "29日", "30日", "31日"]

    public override required init(_ year: Int, _ month: Int, _ day: Int) throws {
        try Self.validate(year, month, day)
        try super.init(year, month, day)
    }

    public class func validate(_ year: Int, _ month: Int, _ day: Int) throws {
        var illegal: Bool = day < 1
        if !illegal {
            if year == 1582 && month == 10 {
                illegal = (day > 4 && day < 15) || day > 31
            } else {
                illegal = day > (try SolarMonth.fromYm(year, month).dayCount)
            }
        }
        if illegal {
            throw ArgumentError("illegal solar day: \(year)-\(month)-\(day)")
        }
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) throws -> Self {
        try Self(year, month, day)
    }

    public var week: Week {
        getJulianDay().week
    }

    /// 星座
    public var constellation: Constellation {
        let m: Int = month - 1
        let offset: Int = (day > [19, 18, 20, 19, 20, 21, 22, 22, 22, 23, 22, 21][m]) ? 1 : 0;
        return Constellation.fromIndex(9 + m + offset)
    }
    
    /// 公历月
    public var solarMonth: SolarMonth {
        try! SolarMonth.fromYm(year, month)
    }

    public override func getName() -> String {
        Self.NAMES[day - 1]
    }
    
    public override var description: String {
        "\(solarMonth)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        let d: SolarDay = getJulianDay().next(n).getSolarDay()
        return try Self.fromYmd(d.year, d.month, d.day)
    }

    public func getJulianDay() -> JulianDay {
        JulianDay.fromYmdHms(year, month, day, 0, 0, 0)
    }

    public func isBefore(_ target: SolarDay) -> Bool {
        getCompareIndex() < target.getCompareIndex()
    }

    public func isAfter(_ target: SolarDay) -> Bool {
        getCompareIndex() > target.getCompareIndex()
    }

    public func subtract(_ target: SolarDay) -> Int {
        Int(getJulianDay().subtract(target.getJulianDay()))
    }

    /// 位于当年的索引
    public var indexInYear: Int {
        subtract(try! Self.fromYmd(year, 1, 1))
    }

    /// 节气第几天
    public var termDay: SolarTermDay {
        var y: Int = year
        var i: Int = month * 2
        if i == 24 {
            y += 1
            i = 0
        }
        var term: SolarTerm = SolarTerm.fromIndex(y, i + 1)
        var d: SolarDay = term.getSolarDay()
        while isBefore(d) {
            term = term.next(-1)
            d = term.getSolarDay()
        }
        return SolarTermDay(term, subtract(d))
    }

    /// 节气
    public var term: SolarTerm {
        termDay.solarTerm
    }

    /// 农历日
    public func getLunarDay() -> LunarDay {
        var m: LunarMonth = try! LunarMonth.fromYm(year, month)
        var days: Int = subtract(m.firstJulianDay.getSolarDay())
        while days < 0 {
            m = try! m.next(-1)
            days += m.dayCount
        }
        return try! LunarDay.fromYmd(m.year, m.monthWithLeap, days + 1)
    }

    /// 干支日
    public func getSixtyCycleDay() -> SixtyCycleDay {
        try! SixtyCycleDay.fromSolarDay(self)
    }

    /// 月相第几天
    public var phaseDay: PhaseDay {
        let month: LunarMonth = try! getLunarDay().lunarMonth.next(1)
        var p: Phase = try! Phase.fromIndex(month.year, month.monthWithLeap, 0)
        var d: SolarDay = p.solarDay
        while d.isAfter(self) {
            p = try! p.next(-1)
            d = p.solarDay
        }

        return PhaseDay(p, subtract(d))
    }

    /// 月相
    public var phase: Phase {
        phaseDay.phase
    }
    
    /// 九星
    public var nineStar: NineStar {
        let winterSolstice: SolarDay = SolarTerm.fromIndex(year, 0).getSolarDay()
        let summerSolstice: SolarDay = SolarTerm.fromIndex(year, 12).getSolarDay()
        let nextWinterSolstice: SolarDay = SolarTerm.fromIndex(year + 1, 0).getSolarDay()
        // 距冬至最近的甲子日
        let w: SolarDay = try! winterSolstice.next(winterSolstice.getLunarDay().sixtyCycle.stepsCloseTo(0))
        // 距夏至最近的甲子日
        let s: SolarDay = try! summerSolstice.next(summerSolstice.getLunarDay().sixtyCycle.stepsCloseTo(0))
        // 距下个冬至最近的甲子日
        let n: SolarDay = try! nextWinterSolstice.next(nextWinterSolstice.getLunarDay().sixtyCycle.stepsCloseTo(0))
        // 43210012345678876543210012345
        //      w        s        n
        //     冬至     夏至      冬至
        if (isBefore(w)) {
            return NineStar.fromIndex(w.subtract(self) - 1)
        }
        if (isBefore(s)) {
            return NineStar.fromIndex(subtract(w))
        }
        return NineStar.fromIndex(isBefore(n) ? n.subtract(self) - 1 : subtract(n))
    }

    /// 三伏天
    public var dogDay: DogDay? {
        // 初伏，夏至后第3个庚日
        let d0: SolarDay = Event.builder().termHeavenStem(12, 6, 20).build().getSolarDay(year)!
        // 中伏，夏至后第4个庚日
        let d1: SolarDay = Event.builder().termHeavenStem(12, 6, 30).build().getSolarDay(year)!
        // 末伏，立秋后第1个庚日
        let d2: SolarDay = Event.builder().termHeavenStem(15, 6, 0).build().getSolarDay(year)!
        if (isBefore(d0) || isAfter(try! d2.next(9))) {
            return nil
        }
        if (!isBefore(d2)) {
            return DogDay(Dog.fromIndex(2), subtract(d2))
        }
        return isBefore(d1) ? DogDay(Dog.fromIndex(0), subtract(d0)) : DogDay(Dog.fromIndex(1), subtract(d1))
    }

    /// 数九天
    public var nineDay: NineDay? {
        var start: SolarDay = SolarTerm.fromIndex(year + 1, 0).getSolarDay()
        if isBefore(start) {
            start = SolarTerm.fromIndex(year, 0).getSolarDay()
        }

        let end: SolarDay = try! start.next(81)
        if isBefore(start) || !isBefore(end) {
            return nil
        }

        let days: Int = subtract(start)
        return NineDay(Nine.fromIndex(days / 9), days % 9)
    }

    /// 梅雨天（芒种后的第1个丙日入梅，小暑后的第1个未日出梅）
    public var plumRainDay: PlumRainDay? {
        // 入梅，芒种后第1个丙日
        let start: SolarDay = Event.builder().termHeavenStem(11, 2, 0).build().getSolarDay(year)!
        // 出梅，小暑后第1个未日
        let end: SolarDay = Event.builder().termEarthBranch(13, 7, 0).build().getSolarDay(year)!
        if (isBefore(start) || isAfter(end)) {
            return nil
        }
        return self == end ? PlumRainDay(PlumRain.fromIndex(1), 0) : PlumRainDay(PlumRain.fromIndex(0), subtract(start))
    }

    /// 七十二候
    public var phenologyDay: PhenologyDay {
        let d: SolarTermDay = termDay
        let dayIndex: Int = d.dayIndex
        var index: Int = dayIndex / 5
        if index > 2 {
            index = 2
        }

        let term: SolarTerm = d.solarTerm
        return PhenologyDay(try! Phenology.fromIndex(term.year, term.index * 3 + index), dayIndex - index * 5)
    }

    /// 候
    public var phenology: Phenology {
        phenologyDay.phenology
    }

    /// 人元司令分野
    public var hideHeavenStemDay: HideHeavenStemDay {
        let dayCounts: [Int] = [3, 5, 7, 9, 10, 30]
        var t: SolarTerm = term
        if t.isQi {
            t = t.next(-1)
        }

        var dayIndex: Int = subtract(t.getSolarDay())
        let startIndex: Int = (t.index - 1) * 3
        let s: String = "93705542220504xx1513904541632524533533105544806564xx7573304542018584xx95"
        let data = String(s.dropFirst(startIndex).prefix(6))
        var days: Int = 0
        var heavenStemIndex: Int = 0
        var typeIndex: Int = 0
        while typeIndex < 3 {
            let i: Int = typeIndex * 2
            let d: String = String(data[data.index(data.startIndex, offsetBy: i)])
            var count: Int = 0
            if d != "x" {
                heavenStemIndex = Int(d)!
                count = dayCounts[Int(String(data[data.index(data.startIndex, offsetBy: i + 1)]))!]
                days += count
            }

            if dayIndex <= days {
                dayIndex -= days - count
                break
            }

            typeIndex += 1
        }

        var type: HideHeavenStemType = HideHeavenStemType.MAIN
        if 0 == typeIndex {
            type = HideHeavenStemType.RESIDUAL
        } else if 1 == typeIndex {
            type = HideHeavenStemType.MIDDLE
        }

        return HideHeavenStemDay(HideHeavenStem(heavenStemIndex, type), dayIndex)
    }
    
    /// 法定假日，如果当天不是法定假日，返回nil
    public var legalHoliday: LegalHoliday? {
        LegalHoliday.fromYmd(year, month, day)
    }
    
    /// 公历现代节日，如果当天不是公历现代节日，返回nil
    public var festival: SolarFestival? {
        SolarFestival.fromYmd(year, month, day)
    }
    
    /// 藏历日
    public func getRabByungDay() throws -> RabByungDay {
        try RabByungDay.fromSolarDay(self)
    }
    
    /// 公历周
    public func getSolarWeek(_ start: Int) -> SolarWeek {
        try! SolarWeek.fromYm(year, month, Int(ceil((Double(day + Self.fromYmd(year, month, 1).week.next(-start).index)) / 7.0)) - 1, start)
    }
    
    /// 回历日
    public func getHijriDay() -> HijriDay {
        let s: SolarDay = try! SolarDay.fromYmd(622, 7, 16)
        var d: Int = subtract(s)
        let z: Int = floorDiv(d, 10631)
        d -= z * 10631
        let y: Int = Int(floor((Double(d) + 0.5) / 354.366))
        d -= Int(floor(Double(y) * 354.366 + 0.5))
        let m: Int = Int(floor((Double(d) + 0.11) / 29.51))
        d -= Int(floor(Double(m) * 29.5 + 0.5))
        return try! HijriDay.fromYmd(z * 30 + y + 1, m + 1, d + 1)
    }
}
