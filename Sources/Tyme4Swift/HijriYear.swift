import Foundation

/// 回历年
public class HijriYear: YearUnit {

    required override init(_ year: Int) throws {
        try Self.validate(year)
        try super.init(year)
    }
    
    public class func validate(_ year: Int) throws {
        try validateRange(year, -640, 9666, "hijri year")
    }

    public class func fromYear(_ year: Int) throws -> Self {
        try Self(year)
    }

    /// 天数（平年354天，闰年355天）
    public var dayCount: Int {
        isLeap ? 355 : 354
    }

    /// 是否闰年(1个闰周为30年，1个闰周中第2、5、7、10、13、16、18、21、24、26、29年为闰年)
    public var isLeap: Bool {
        let i: Int = indexOf(year - 1, 30)
        return i == 1 || i == 4 || i == 6 || i == 9 || i == 12 || i == 15 || i == 17 || i == 20 || i == 23 || i == 25 || i == 28
    }
    
    public override func getName() -> String {
        "\(year)年"
    }
    
    public override func next(_ n: Int) throws -> Self {
        try Self.fromYear(year + n)
    }
    
    /// 月份列表
    public var months: [HijriMonth] {
        var l: [HijriMonth] = [HijriMonth]()
        for i: Int in (1..<13) {
            l.append(try! HijriMonth.fromYm(year, i))
        }
        return l
    }
    
    public var firstMonth: HijriMonth {
        try! HijriMonth.fromYm(year, 1)
    }
}
