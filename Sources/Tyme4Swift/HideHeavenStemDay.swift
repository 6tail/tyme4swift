import Foundation

/// 人元司令分野（地支藏干+天索引）
public class HideHeavenStemDay: AbstractCultureDay {
    
    init(_ hideHeavenStem: HideHeavenStem, _ dayIndex: Int) {
        super.init(culture: hideHeavenStem as AbstractCulture, dayIndex: dayIndex)
    }
    
    /// 藏干
    public var hideHeavenStem: HideHeavenStem {
        culture as! HideHeavenStem
    }
    
    public override func getName() -> String {
        let heavenStem: HeavenStem = hideHeavenStem.heavenStem
        return heavenStem.getName() + heavenStem.element.getName()
    }
    
    public override var description: String {
        "\(getName())第\(dayIndex + 1)天"
    }
}
