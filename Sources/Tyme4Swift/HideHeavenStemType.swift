/// 藏干类型
public enum HideHeavenStemType: Int {
    case RESIDUAL = 0
    case MIDDLE = 1
    case MAIN = 2

    public func getName() -> String {
        switch self {
        case .RESIDUAL: return "余气"
        case .MIDDLE: return "中气"
        case .MAIN: return "本气"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .RESIDUAL: return 0
        case .MIDDLE: return 1
        case .MAIN: return 2
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .RESIDUAL
        case 1: return .MIDDLE
        case 2: return .MAIN
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "余气": return .RESIDUAL
        case "中气": return .MIDDLE
        case "本气": return .MAIN
        default: return nil
        }
    }
    
    public var description: String {
        getName()
    }
}
