import Foundation

/// 数九天
public class NineDay: AbstractCultureDay {
    
    init(_ nine: Nine, _ dayIndex: Int) {
        super.init(culture: nine as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 数九
    public var nine: Nine {
        culture as! Nine
    }
}
