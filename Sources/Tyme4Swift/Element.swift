import Foundation

/// 五行
public class Element: LoopTyme {
    
    public static var NAMES: [String] = ["木", "火", "土", "金", "水"]

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
    
    /// 我生者
    public func getReinforce() -> Self {
        next(1)
    }
    
    /// 我克者
    public func getRestrain() -> Self {
        next(2)
    }
    
    /// 生我者
    public func getReinforced() -> Self {
        next(-1)
    }
    
    /// 克我者
    public func getRestrained() -> Self {
        next(-2)
    }
    
    /// 方位
    public func getDirection() -> Direction {
        Direction.fromIndex([2, 8, 4, 6, 0][index])
    }
}
