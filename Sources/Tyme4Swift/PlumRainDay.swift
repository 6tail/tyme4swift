import Foundation

/// 梅雨天
public class PlumRainDay: AbstractCultureDay {
    
    init(_ plumRain: PlumRain, _ dayIndex: Int) {
        super.init(culture: plumRain as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 梅雨
    public var plumRain: PlumRain {
        culture as! PlumRain
    }
    
    public override var description: String {
        plumRain.index == 0 ? super.description : culture.getName()
    }
}
