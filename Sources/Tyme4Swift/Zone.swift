import Foundation

/// 宫
public class Zone: LoopTyme {
    public static var NAMES: [String] = ["东", "北", "西", "南"]

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
    
    /// 方位
    public func getDirection() -> Direction {
        try! Direction.fromName(getName())
    }
    
    /// 神兽
    public func getBeast() -> Beast {
        Beast.fromIndex(index)
    }
}
