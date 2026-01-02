import Foundation

/// 运（20年=1运，3运=1元）
public class Twenty: LoopTyme {
    public static var NAMES: [String] = ["一运", "二运", "三运", "四运", "五运", "六运", "七运", "八运", "九运"]

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
    
    /// 元
    public var sixty: Sixty {
        Sixty.fromIndex(index / 3)
    }
}
