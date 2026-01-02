import Foundation

/// 七十二候
public class PhenologyDay: AbstractCultureDay {
    
    init(_ phenology: Phenology, _ dayIndex: Int) {
        super.init(culture: phenology as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 三伏
    public var phenology: Phenology {
        culture as! Phenology
    }
}
