import Foundation

/// 年
public class YearUnit: AbstractTyme {
    /// 年
    public private(set) var year: Int
    
    internal init(_ year: Int) throws {
        self.year = year
    }
}
