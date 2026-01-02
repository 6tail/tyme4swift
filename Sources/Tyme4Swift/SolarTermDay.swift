import Foundation

/// 节气第几天
public class SolarTermDay: AbstractCultureDay {
    
    init(_ solarTerm: SolarTerm, _ dayIndex: Int) {
        super.init(culture: solarTerm as AbstractCulture, dayIndex: dayIndex)
    }
    
    public var solarTerm: SolarTerm {
        culture as! SolarTerm
    }
}
