/// 阴阳
public enum YinYang: Int {
    case YIN = 0
    case YANG = 1

    public func getName() -> String {
        switch self {
        case .YIN:
            return "阴"
        case .YANG:
            return "阳"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .YIN:
            return 0
        case .YANG:
            return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        if code == 0 {
            return .YIN
        }
        if code == 1 {
            return .YANG
        }
        return nil
    }

    public static func fromName(_ name: String) -> Self? {
        if name == "阴" {
            return .YIN
        }
        if name == "阳" {
            return .YANG
        }
        return nil
    }
    
    public var description: String {
        getName()
    }
}
