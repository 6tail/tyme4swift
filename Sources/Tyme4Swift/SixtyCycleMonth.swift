import Foundation

/// 干支月
public class SixtyCycleMonth: AbstractTyme {
    /// 年
    public private(set) var sixtyCycleYear: SixtyCycleYear
    /// 月
    public private(set) var month: SixtyCycle

    required init(_ year: SixtyCycleYear, _ month: SixtyCycle) {
        self.sixtyCycleYear = year
        self.month = month
    }

    public class func fromYm(_ year: Int, _ index: Int) throws -> Self {
        let y: SixtyCycleYear = try SixtyCycleYear.fromYear(year)
        return Self(y, try y.firstMonth.next(index).sixtyCycle)
    }

    public override func getName() -> String {
        "\(month)月"
    }

    public override var description: String {
        "\(sixtyCycleYear)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        Self(try SixtyCycleYear.fromYear((sixtyCycleYear.year * 12 + indexInYear + n) / 12), month.next(n))
    }

    /// 位于当年的索引(0-11)，寅月为0，依次类推
    public var indexInYear: Int {
        month.earthBranch.next(-2).index
    }

    /// 年柱
    public var year: SixtyCycle {
        sixtyCycleYear.sixtyCycle
    }

    /// 干支
    public var sixtyCycle: SixtyCycle {
        month
    }

    /// 九星
    public var nineStar: NineStar {
        var i: Int = month.earthBranch.index
        if i < 2 {
            i += 3
        }
        return NineStar.fromIndex(27 - year.earthBranch.index % 3 * 3 - i)
    }

    /// 太岁方位
    public var jupiterDirection: Direction {
        let n: Int = [ 7, -1, 1, 3 ][month.earthBranch.next(-2).index % 4]
        return n == -1 ? month.heavenStem.direction : Direction.fromIndex(n)
    }
}
