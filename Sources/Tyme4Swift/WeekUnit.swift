import Foundation

/// 周
public class WeekUnit: MonthUnit {
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
        if index < 0 || index > 5 {
            throw ArgumentError("illegal week index: \(index)")
        }
        if start < 0 || start > 6 {
            throw ArgumentError("illegal week start: \(start)")
        }
    }
    
    public var start: Week {
        Week.fromIndex(startIndex)
    }
}
