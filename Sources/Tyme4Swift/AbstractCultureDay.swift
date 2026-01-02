import Foundation

/// 带天索引的传统文化抽象
public class AbstractCultureDay: AbstractCulture {
    /// 传统文化
    public private(set) var culture: AbstractCulture
    
    /// 天索引
    public private(set) var dayIndex: Int
    
    init(culture: AbstractCulture, dayIndex: Int) {
        self.culture = culture
        self.dayIndex = dayIndex
    }
    
    public override func getName() -> String {
        culture.getName()
    }
    
    public override var description: String {
        "\(culture)第\(dayIndex + 1)天"
    }
}
