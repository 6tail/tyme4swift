import Foundation

/// 二十八宿
public class TwentyEightStar: LoopTyme {
    public static var NAMES: [String] = ["角", "亢", "氐", "房", "心", "尾", "箕", "斗", "牛", "女", "虚", "危", "室", "壁", "奎", "娄", "胃", "昴", "毕", "觜", "参", "井", "鬼", "柳", "星", "张", "翼", "轸"]

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
    
    /// 七曜
    public var sevenStar: SevenStar {
        SevenStar.fromIndex(index % 7 + 4)
    }
    
    /// 九野
    public var land: Land {
        Land.fromIndex([4, 4, 4, 2, 2, 2, 7, 7, 7, 0, 0, 0, 0, 5, 5, 5, 6, 6, 6, 1, 1, 1, 8, 8, 8, 3, 3, 3][index])
    }
    
    /// 宫
    public var zone: Zone {
        Zone.fromIndex(index / 7)
    }
    
    /// 动物
    public func getAnimal() -> Animal {
        Animal.fromIndex(index)
    }
    
    /// 吉凶
    public var luck: Luck {
        Luck.fromIndex([0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0][index])
    }
}
