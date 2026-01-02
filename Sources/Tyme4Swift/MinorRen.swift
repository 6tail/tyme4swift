import Foundation

/// 小六壬
public class MinorRen: LoopTyme {
    public static var NAMES: [String] = ["大安", "留连", "速喜", "赤口", "小吉", "空亡"]

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

    /// 吉凶
    public var luck: Luck {
        Luck.fromIndex(index % 2)
    }

    /// 五行
    public func getElement() -> Element {
        Element.fromIndex([0, 4, 1, 3, 0, 2][index])
    }
}
