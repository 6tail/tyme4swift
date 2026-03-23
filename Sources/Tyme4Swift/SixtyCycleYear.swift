import Foundation

/// 干支年
public class SixtyCycleYear: AbstractTyme {
    /// 年
    public private(set) var year: Int

    required init(_ year: Int) throws {
        try Self.validate(year)
        self.year = year
    }
    
    public class func validate(_ year: Int) throws {
        if year < 1 || year > 9999 {
            throw ArgumentError("illegal sixty cycle year: \(year)")
        }
    }

    /// 从年初始化
    /// - Parameter year: 年，支持-1到9999年
    /// - Returns: 干支年
    public class func fromYear(_ year: Int) throws -> Self {
        try Self(year)
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        SixtyCycle.fromIndex(year - 4)
    }
    
    public override func getName() -> String {
        "\(sixtyCycle)年"
    }
    
    public override func next(_ n: Int) throws -> Self {
        try Self.fromYear(year + n)
    }
    
    /// 运
    public var twenty: Twenty {
        Twenty.fromIndex(Int(floor(Double(year - 1864) / 20.0)))
    }

    /// 九星
    public var nineStar: NineStar {
        NineStar.fromIndex(63 + twenty.sixty.index * 3 - sixtyCycle.index)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        Direction.fromIndex([0, 7, 7, 2, 3, 3, 8, 1, 1, 6, 0, 0][sixtyCycle.earthBranch.index])
    }

    /// 首月（五虎遁：甲己之年丙作首，乙庚之岁戊为头，丙辛必定寻庚起，丁壬壬位顺行流，若问戊癸何方发，甲寅之上好追求。）
    public var firstMonth: SixtyCycleMonth {
        SixtyCycleMonth(self, SixtyCycle.fromIndex(year * 12 - 46))
    }

    /// 月份列表
    public var months: [SixtyCycleMonth] {
        var l: [SixtyCycleMonth] = [SixtyCycleMonth]()
        let m: SixtyCycleMonth = firstMonth
        l.append(m)
        for i: Int in 1..<12 {
            l.append(try! m.next(i))
        }
        return l
    }
}
