import Foundation

/// 三柱
public class ThreePillars: AbstractCulture {
    /// 年柱
    public private(set) var year: SixtyCycle
    
    /// 月柱
    public private(set) var month: SixtyCycle
    
    /// 日柱
    public private(set) var day: SixtyCycle
    
    init(_ year: SixtyCycle, _ month: SixtyCycle, _ day: SixtyCycle) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    init(_ year: String, _ month: String, _ day: String) throws {
        self.year = try SixtyCycle.fromName(year)
        self.month = try SixtyCycle.fromName(month)
        self.day = try SixtyCycle.fromName(day)
    }
    
    public override func getName() -> String {
        "\(year) \(month) \(day)"
    }
    
    public func getSolarDays(_ startYear: Int, _ endYear: Int) -> [SolarDay] {
        var l: [SolarDay] = [SolarDay]()
        // 月地支距寅月的偏移值
        var m: Int = month.earthBranch.next(-2).index
        // 月天干要一致
        if HeavenStem.fromIndex((year.heavenStem.index + 1) * 2 + m) != month.heavenStem {
            return l
        }

        // 1年的立春是辛酉，序号57
        var y: Int = year.next(-57).index + 1
        // 节令偏移值
        m *= 2
        let baseYear: Int = startYear - 1
        if baseYear > y {
            y += 60 * Int(ceil(Double(baseYear - y) / 60.0))
        }

        while y <= endYear {
            // 立春为寅月的开始
            var term: SolarTerm = SolarTerm.fromIndex(y, 3)
            // 节令推移，年干支和月干支就都匹配上了
            if m > 0 {
                term = term.next(m)
            }

            var solarDay: SolarDay = term.julianDay.getSolarDay()
            if solarDay.year >= startYear {
                // 日干支和节令干支的偏移值
                let d = day.next(-solarDay.getLunarDay().sixtyCycle.index).index
                if d > 0 {
                    // 从节令推移天数
                    solarDay = try! solarDay.next(d)
                }

                // 验证一下
                if solarDay.getSixtyCycleDay().threePillars == self {
                    l.append(solarDay)
                }
            }

            y += 60
        }
        return l
    }
}
