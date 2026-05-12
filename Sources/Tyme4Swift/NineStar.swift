import Foundation

/// 九星
public class NineStar: LoopTyme {
    public static var NAMES: [String] = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]
    public static var COLORS: [String] = ["白", "黑", "碧", "绿", "黄", "白", "赤", "白", "紫"]

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
    
    /// 颜色
    public var color: String {
        Self.COLORS[index]
    }

    /// 五行
    public var element: Element {
        direction.getElement()
    }

    /// 北斗九星
    public var dipper: Dipper {
        Dipper.fromIndex(index)
    }

    /// 方位
    public var direction: Direction {
        Direction.fromIndex(index)
    }

    public override var description: String {
        "\(getName())\(color)\(element)"
    }
}
