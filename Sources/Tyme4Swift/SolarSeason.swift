import Foundation

/// 公历季度
public class SolarSeason: YearUnit {
    public static var NAMES: [String] = ["一季度", "二季度", "三季度", "四季度"]

    /// 索引，0-3
    public private(set) var index: Int

    required init(_ year: Int, _ index: Int) throws {
        try Self.validate(year, index)
        self.index = index
        try super.init(year)
    }
    
    public class func validate(_ year: Int, _ index: Int) throws {
        try validateRange(index, 0, 3, "solar season index")
        try SolarYear.validate(year)
    }

    public class func fromIndex(_ year: Int, _ index: Int) throws -> Self {
        try Self(year, index)
    }
    
    /// 公历年
    public var solarYear: SolarYear {
        try! SolarYear.fromYear(year)
    }

    public override func getName() -> String {
        Self.NAMES[index]
    }
    
    public override var description: String {
        "\(solarYear)\(getName())"
    }

    public override func next(_ n: Int) throws -> Self {
        let i: Int = index + n
        return try Self.fromIndex((year * 4 + i) / 4, indexOf(i, 4))
    }
    
    /// 月份列表
    public var months: [SolarMonth] {
        var l: [SolarMonth] = [SolarMonth]()
        for i: Int in (1..<4) {
            l.append(try! SolarMonth.fromYm(year, index * 3 + i))
        }
        return l
    }
}
