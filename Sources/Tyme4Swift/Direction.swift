import Foundation

/// 方位
public class Direction: LoopTyme {
    
    /// 依据后天八卦排序（0坎北, 1坤西南, 2震东, 3巽东南, 4中, 5乾西北, 6兑西, 7艮东北, 8离南）
    public static var NAMES: [String] = ["北", "西南", "东", "东南", "中", "西北", "西", "东北", "南"]

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
    
    /// 九野
    public func getLand() -> Land {
        Land.fromIndex(index)
    }
    
    /// 五行
    public func getElement() -> Element {
        Element.fromIndex([4, 2, 0, 0, 2, 3, 3, 2, 1][index])
    }
}
