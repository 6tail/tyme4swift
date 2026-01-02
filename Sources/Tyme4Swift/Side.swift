/// 内外
public enum Side: Int {
    case IN = 0
    case OUT = 1

    public func getName() -> String {
        switch self {
        case .IN:
            return "内"
        case .OUT:
            return "外"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .IN:
            return 0
        case .OUT:
            return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        if code == 0 {
            return .IN
        }
        if code == 1 {
            return .OUT
        }
        return nil
    }

    public static func fromName(_ name: String) -> Self? {
        if name == "内" {
            return .IN
        }
        if name == "外" {
            return .OUT
        }
        return nil
    }
    
    public var description: String {
        getName()
    }
}
