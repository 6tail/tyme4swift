import Foundation

/// 周
public class WeekUnit: MonthUnit {
    public static var NAMES: [String] = ["第一周", "第二周", "第三周", "第四周", "第五周", "第六周"]
    
    /// 索引，0-5
    public private(set) var index: Int
    
    /// 起始星期，1234560分别代表星期一至星期天
    public private(set) var startIndex: Int
    
    internal init(_ year: Int, _ month: Int, _ index: Int, _ start: Int) throws {
        try Self.validate(index, start)
        self.index = index
        self.startIndex = start
        try super.init(year, month)
    }
    
    public class func validate(_ index: Int, _ start: Int) throws {
        try validateRange(index, 0, 5, "week index")
        try validateRange(start, 0, 6, "week start")
    }
    
    public var start: Week {
        Week.fromIndex(startIndex)
    }
}
