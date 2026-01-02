import Foundation

/// 彭祖百忌
public class PengZu: AbstractCulture {
    
    public private(set) var pengZuHeavenStem: PengZuHeavenStem
    public private(set) var pengZuEarthBranch: PengZuEarthBranch
    
    required init(_ sixtyCycle: SixtyCycle) {
        self.pengZuHeavenStem = PengZuHeavenStem.fromIndex(sixtyCycle.heavenStem.index)
        self.pengZuEarthBranch = PengZuEarthBranch.fromIndex(sixtyCycle.earthBranch.index)
    }
    
    public class func fromSixtyCycle(_ sixtyCycle: SixtyCycle) -> Self {
        Self(sixtyCycle)
    }
    
    public override func getName() -> String {
        "\(pengZuHeavenStem) \(pengZuEarthBranch)"
    }
}
