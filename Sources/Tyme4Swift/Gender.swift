/// 性别
public enum Gender: Int {
    case WOMAN = 0
    case MAN = 1

    public func getName() -> String {
        switch self {
        case .WOMAN:
            return "女"
        case .MAN:
            return "男"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .WOMAN:
            return 0
        case .MAN:
            return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        if code == 0 {
            return .WOMAN
        }
        if code == 1 {
            return .MAN
        }
        return nil
    }

    public static func fromName(_ name: String) -> Self? {
        if name == "女" {
            return .WOMAN
        }
        if name == "男" {
            return .MAN
        }
        return nil
    }
    
    public var description: String {
        getName()
    }
}
