import Foundation

/// 逐日胎神
public class FetusDay: AbstractCulture {
    public private(set) var fetusHeavenStem: FetusHeavenStem
    public private(set) var fetusEarthBranch: FetusEarthBranch
    public private(set) var side: Side
    public private(set) var direction: Direction

    required init(_ sixtyCycle: SixtyCycle) {
        fetusHeavenStem = FetusHeavenStem.fromIndex(sixtyCycle.heavenStem.index % 5)
        fetusEarthBranch = FetusEarthBranch.fromIndex(sixtyCycle.earthBranch.index % 6)
        let index: Int = [3, 3, 8, 8, 8, 8, 8, 1, 1, 1, 1, 1, 1, 6, 6, 6, 6, 6, 5, 5, 5, 5, 5, 5, 0, 0, 0, 0, 0, -9, -9, -9, -9, -9, -5, -5, -1, -1, -1, -3, -7, -7, -7, -7, -5, 7, 7, 7, 7, 7, 7, 2, 2, 2, 2, 2, 3, 3, 3, 3][sixtyCycle.index]
        side = index < 0 ? Side.IN : Side.OUT
        direction = Direction.fromIndex(index)
    }

    public class func fromSixtyCycleDay(_ sixtyCycleDay: SixtyCycleDay) -> Self {
        Self(sixtyCycleDay.sixtyCycle)
    }

    public class func fromLunarDay(_ lunarDay: LunarDay) -> Self {
        Self(lunarDay.sixtyCycle)
    }

    public override func getName() -> String {
        var s = fetusHeavenStem.getName() + fetusEarthBranch.getName()
        switch s {
        case "门门":
            s = "占大门"
            break
        case "碓磨碓":
            s = "占碓磨"
            break
        case "房床床":
            s = "占房床"
            break
        default:
            if s.hasPrefix("门") {
                s = "占" + s
            }

            break
        }

        s += " "

        if Side.IN == side {
            s += "房"
        }

        s += side.getName()

        let directionName = direction.getName()
        if Side.OUT == side && "北南西东".contains(directionName) {
            s += "正"
        }

        s += directionName
        return s
    }
}
