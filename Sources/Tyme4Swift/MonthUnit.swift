import Foundation

/// 月
public class MonthUnit: YearUnit {
    /// 月
    public private(set) var month: Int
    
    internal init(_ year: Int, _ month: Int) throws {
        self.month = month
        try super.init(year)
    }
}
