import Foundation

/// 北斗九星
public class Dipper: LoopTyme {
    public static var NAMES: [String] = ["天枢", "天璇", "天玑", "天权", "玉衡", "开阳", "摇光", "洞明", "隐元"]

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
}
