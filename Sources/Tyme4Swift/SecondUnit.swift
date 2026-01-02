import Foundation

/// 秒
public class SecondUnit: DayUnit {
    /// 时
    public private(set) var hour: Int
    
    /// 分
    public private(set) var minute: Int
    
    /// 秒
    public private(set) var second: Int
    
    internal init(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) throws {
        self.hour = hour
        self.minute = minute
        self.second = second
        try super.init(year, month, day)
    }
    
    public class func validate(_ hour: Int, _ minute: Int, _ second: Int) throws {
        if hour < 0 || hour > 23 {
            throw ArgumentError("illegal hour: \(hour)")
        }
        if minute < 0 || minute > 59 {
            throw ArgumentError("illegal minute: \(hour)")
        }
        if second < 0 || second > 59 {
            throw ArgumentError("illegal second: \(hour)")
        }
    }
}
