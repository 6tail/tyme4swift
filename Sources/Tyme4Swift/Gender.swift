/// 性别
public enum Gender: Int {
    case WOMAN = 0
    case MAN = 1

    public func getName() -> String {
        switch self {
        case .WOMAN: return "女"
        case .MAN: return "男"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .WOMAN: return 0
        case .MAN: return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .WOMAN
        case 1: return .MAN
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "女": return .WOMAN
        case "男": return .MAN
        default: return nil
        }
    }
    
    public var description: String {
        getName()
    }
}
