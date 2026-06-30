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
        try validateRange(hour, 0, 23, "hour")
        try validateRange(minute, 0, 59, "minute")
        try validateRange(second, 0, 59, "second")
    }
    
    /// 当天秒数
    public func getSecondsInDay() -> Int {
        hour * 3600 + minute * 60 + second
    }
    
    public override func getCompareIndex() -> Int {
        super.getCompareIndex() * 86400 + getSecondsInDay()
    }
}
