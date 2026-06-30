import Foundation

/// 月
public class MonthUnit: YearUnit {
    /// 月
    public private(set) var month: Int
    
    internal init(_ year: Int, _ month: Int) throws {
        self.month = month
        try super.init(year)
    }
    
    public override func getCompareIndex() -> Int {
        super.getCompareIndex() + (month > 0 ? month * 2 : -month * 2 + 1) * 100
    }
}
