import Foundation

/// 日
public class DayUnit: MonthUnit {
    /// 日
    public private(set) var day: Int
    
    internal init(_ year: Int, _ month: Int, _ day: Int) throws {
        self.day = day
        try super.init(year, month)
    }
}
