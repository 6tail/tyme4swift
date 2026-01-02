import Foundation

/// 儒略日
public class JulianDay: AbstractTyme {
    /// 2000年儒略日数(2000-1-1 12:00:00 UTC)
    public private(set) static var J2000: Double = 2451545
    
    /// 儒略日
    public private(set) var day: Double
    
    required init(_ day: Double) {
        self.day = day
    }
    
    public class func fromJulianDay(_ day: Double) -> Self {
        Self(day)
    }
    
    public class func fromYmdHms(_ year: Int, _ month: Int, _ day: Int, _ hour: Int, _ minute: Int, _ second: Int) -> Self {
        var y: Int = year
        var m: Int = month
        let d: Double = Double(day) + ((Double(second) / 60.0 + Double(minute)) / 60.0 + Double(hour)) / 24.0
        var n: Int = 0
        let g: Bool = y * 372 + m * 31 + Int(d) >= 588829
        if (m <= 2) {
            m += 12
            y -= 1
        }
        if (g) {
            n = Int(Double(y) * 0.01)
            n = 2 - n + Int(Double(n) * 0.25)
        }
        return Self(Double(Int(365.25 * Double(y + 4716))) + Double(Int(30.6001 * Double(m + 1))) + d + Double(n) - 1524.5)
    }
    
    public override func getName() -> String {
        String(day)
    }
    
    public override func next(_ n: Int) -> Self {
        Self(day + Double(n))
    }
    
    public var week: Week {
        Week.fromIndex(Int(day + 0.5) + 7000001)
    }
    
    public func subtract(_ target: JulianDay) -> Double {
        day - target.day
    }
    
    public func getSolarDay() -> SolarDay {
        getSolarTime().solarDay
    }
    
    public func getSolarTime() -> SolarTime {
        var d: Int = Int(day + 0.5)
        var f: Double = Double(day) + 0.5 - Double(d)

        if (d >= 2299161) {
            let c: Int = Int((Double(d) - 1867216.25) / 36524.25)
            d += 1 + c - Int(Double(c) * 0.25)
        }
        d += 1524
        var y: Int = Int((Double(d) - 122.1) / 365.25)
        d -= Int(365.25 * Double(y))
        var m: Int = Int(Double(d) / 30.601)
        d -= Int(30.601 * Double(m))
        if (m > 13) {
            m -= 12
        } else {
            y -= 1
        }
        m -= 1
        y -= 4715
        f *= 24.0
        let hour: Int = Int(f)

        f -= Double(hour)
        f *= 60.0
        let minute: Int = Int(f)

        f -= Double(minute)
        f *= 60.0
        let second: Int = Int(round(f))
        return second < 60 ? try! SolarTime.fromYmdHms(y, m, d, hour, minute, second) : try! SolarTime.fromYmdHms(y, m, d, hour, minute, second - 60).next(60)
    }
}
