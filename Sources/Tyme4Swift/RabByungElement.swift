import Foundation

/// 藏历五行
public class RabByungElement: Element {
    public override class var NAMES: [String] {
        ["木", "火", "土", "铁", "水"]
    }
    
    required init(_ names: [String], index: Int? = nil, name: String? = nil) throws {
        try super.init(names, index: index, name: name)
    }
    
    public override class func fromIndex(_ index: Int) -> Self {
        try! Self(Self.NAMES, index: index)
    }
    
    public override class func fromName(_ name: String) throws -> Self {
        try Self(Self.NAMES, name: name)
    }
    
    public override func next(_ n: Int) -> Self {
        Self.fromIndex(nextIndex(n))
    }
}
