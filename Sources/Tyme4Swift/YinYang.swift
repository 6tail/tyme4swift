/// 阴阳
public enum YinYang: Int {
    case YIN = 0
    case YANG = 1

    public func getName() -> String {
        switch self {
        case .YIN: return "阴"
        case .YANG: return "阳"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .YIN: return 0
        case .YANG: return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .YIN
        case 1: return .YANG
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "阴": return .YIN
        case "阳": return .YANG
        default: return nil
        }
    }
    
    public var description: String {
        getName()
    }
}
