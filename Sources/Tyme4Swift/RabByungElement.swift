import Foundation

/// 藏历五行
public class RabByungElement: Element {

    required init(index: Int? = nil, name: String? = nil) throws {
        try super.init(index: index, name: name)
    }
    
    public override class func fromIndex(_ index: Int) -> Self {
        try! Self(index: index)
    }
    
    public override class func fromName(_ name: String) throws -> Self {
        try Self(name: name.replacingOccurrences(of: "铁", with: "金"))
    }
    
    public override func next(_ n: Int) -> Self {
        Self.fromIndex(nextIndex(n))
    }
    
    public override func getName() -> String {
        super.getName().replacingOccurrences(of: "金", with: "铁")
    }
}
