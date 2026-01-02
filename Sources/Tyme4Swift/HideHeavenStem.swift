import Foundation

/// 藏干（即人元，司令取天干，分野取天干的五行）
public class HideHeavenStem: AbstractCulture {
    /// 天干
    public private(set) var heavenStem: HeavenStem
    
    /// 藏干类型
    public private(set) var type: HideHeavenStemType
    
    init(_ heavenStem: HeavenStem, _ type: HideHeavenStemType) {
        self.heavenStem = heavenStem
        self.type = type
    }
    
    init(_ heavenStemName: String, _ type: HideHeavenStemType) throws {
        self.heavenStem = try HeavenStem.fromName(heavenStemName)
        self.type = type
    }
    
    init(_ heavenStemIndex: Int, _ type: HideHeavenStemType) {
        self.heavenStem = HeavenStem.fromIndex(heavenStemIndex)
        self.type = type
    }
    
    public override func getName() -> String {
        "\(heavenStem)"
    }
}
