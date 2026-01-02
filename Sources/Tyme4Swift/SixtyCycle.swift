import Foundation

/// 六十甲子(六十干支周)
public class SixtyCycle: LoopTyme {
    public static var NAMES: [String] = ["甲子", "乙丑", "丙寅", "丁卯", "戊辰", "己巳", "庚午", "辛未", "壬申", "癸酉", "甲戌", "乙亥", "丙子", "丁丑", "戊寅", "己卯", "庚辰", "辛巳", "壬午", "癸未", "甲申", "乙酉", "丙戌", "丁亥", "戊子", "己丑", "庚寅", "辛卯", "壬辰", "癸巳", "甲午", "乙未", "丙申", "丁酉", "戊戌", "己亥", "庚子", "辛丑", "壬寅", "癸卯", "甲辰", "乙巳", "丙午", "丁未", "戊申", "己酉", "庚戌", "辛亥", "壬子", "癸丑", "甲寅", "乙卯", "丙辰", "丁巳", "戊午", "己未", "庚申", "辛酉", "壬戌", "癸亥"]

    required init(index: Int? = nil, name: String? = nil) throws {
        try super.init(Self.NAMES, index, name)
    }
    
    public class func fromIndex(_ index: Int) -> Self {
        try! Self(index: index)
    }
    
    public class func fromName(_ name: String) throws -> Self {
        try Self(name: name)
    }
    
    public override func next(_ n: Int) -> Self {
        Self.fromIndex(nextIndex(n))
    }
    
    /// 天干
    public var heavenStem: HeavenStem {
        HeavenStem.fromIndex(index % HeavenStem.NAMES.count)
    }
    
    /// 地支
    public var earthBranch: EarthBranch {
        EarthBranch.fromIndex(index % EarthBranch.NAMES.count)
    }
    
    /// 纳音
    public var sound: Sound {
        Sound.fromIndex(index / 2)
    }
    
    /// 旬
    public var ten: Ten {
        Ten.fromIndex((heavenStem.index - earthBranch.index) / 2)
    }
    
    /// 旬空(空亡)，因地支比天干多2个，旬空则为每一轮干支一一配对后多出来的2个地支
    public var extraEarthBranches: [EarthBranch] {
        var l: [EarthBranch] = [EarthBranch]()
        let a: EarthBranch = EarthBranch.fromIndex(10 + earthBranch.index - heavenStem.index)
        l.append(a)
        l.append(a.next(1))
        return l
    }
    
    /// 彭祖百忌
    public var pengZu: PengZu {
        PengZu.fromSixtyCycle(self)
    }
}
