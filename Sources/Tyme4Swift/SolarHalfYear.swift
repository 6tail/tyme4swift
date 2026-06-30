import Foundation

/// 公历半年
public class SolarHalfYear: YearUnit {
    public static var NAMES: [String] = ["上半年", "下半年"]
    
    /// 索引，0-1
    public private(set) var index: Int

    required init(_ year: Int, _ index: Int) throws {
        try Self.validate(year, index)
        self.index = index
        try super.init(year)
    }
    
    public class func validate(_ year: Int, _ index: Int) throws {
        try validateRange(index, 0, 1, "solar half year index")
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
        return try Self.fromIndex((year * 2 + i) / 2, indexOf(i, 2))
    }
    
    /// 季度列表
    public var seasons: [SolarSeason] {
        var l: [SolarSeason] = [SolarSeason]()
        for i: Int in (0..<2) {
            l.append(try! SolarSeason.fromIndex(year, index * 2 + i))
        }
        return l
    }
    
    /// 月份列表
    public var months: [SolarMonth] {
        var l: [SolarMonth] = [SolarMonth]()
        for i: Int in (1..<7) {
            l.append(try! SolarMonth.fromYm(year, index * 6 + i))
        }
        return l
    }
}
