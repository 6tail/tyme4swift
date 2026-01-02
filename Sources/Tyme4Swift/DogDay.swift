import Foundation

/// 三伏天
public class DogDay: AbstractCultureDay {
    
    init(_ dog: Dog, _ dayIndex: Int) {
        super.init(culture: dog as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 三伏
    public var dog: Dog {
        culture as! Dog
    }
}
