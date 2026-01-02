/// 藏干类型
public enum HideHeavenStemType: Int {
    case RESIDUAL = 0
    case MIDDLE = 1
    case MAIN = 2

    public func getName() -> String {
        switch self {
        case .RESIDUAL:
            return "余气"
        case .MIDDLE:
            return "中气"
        case .MAIN:
            return "本气"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .RESIDUAL:
            return 0
        case .MIDDLE:
            return 1
        case .MAIN:
            return 1
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        if code == 0 {
            return .RESIDUAL
        }
        if code == 1 {
            return .MIDDLE
        }
        if code == 2 {
            return .MAIN
        }
        return nil
    }

    public static func fromName(_ name: String) -> Self? {
        if name == "余气" {
            return .RESIDUAL
        }
        if name == "中气" {
            return .MIDDLE
        }
        if name == "本气" {
            return .MAIN
        }
        return nil
    }
    
    public var description: String {
        getName()
    }
}
