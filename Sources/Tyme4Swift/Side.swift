/// 内外
public enum Side: Int {
    case IN = 0
    case OUT = 1

    public func getName() -> String {
        switch self {
        case .IN: return "内"
        case .OUT: return "外"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .IN: return 0
        case .OUT: return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .IN
        case 1: return .OUT
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "内": return .IN
        case "外": return .OUT
        default: return nil
        }
    }
    
    public var description: String {
        getName()
    }
}
