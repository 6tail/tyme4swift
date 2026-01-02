import Foundation

/// 月相第几天
public class PhaseDay: AbstractCultureDay {
    
    init(_ phase: Phase, _ dayIndex: Int) {
        super.init(culture: phase as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 月相
    public var phase: Phase {
        culture as! Phase
    }
}
