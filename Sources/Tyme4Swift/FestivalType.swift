/// 节日类型
public enum FestivalType: Int {
    case DAY = 0
    case TERM = 1
    case EVE = 2

    public func getName() -> String {
        switch self {
        case .DAY: return "日期"
        case .TERM: return "节气"
        case .EVE: return "除夕"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .DAY: return 0
        case .TERM: return 1
        case .EVE: return 2
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .DAY
        case 1: return .TERM
        case 2: return .EVE
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "日期": return .DAY
        case "节气": return .TERM
        case "除夕": return .EVE
        default: return nil
        }
    }
    
    public var description: String {
        getName()
    }
}
