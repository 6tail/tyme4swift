/// 事件类型
public enum EventType: Int {
    case SOLAR_DAY = 0
    case SOLAR_WEEK = 1
    case LUNAR_DAY = 2
    case TERM_DAY = 3
    case TERM_HS = 4
    case TERM_EB = 5

    public func getName() -> String {
        switch self {
        case .SOLAR_DAY: return "公历日期"
        case .SOLAR_WEEK: return "几月第几个星期几"
        case .LUNAR_DAY: return "农历日期"
        case .TERM_DAY: return "节气日期"
        case .TERM_HS: return "节气天干"
        case .TERM_EB: return "节气地支"
        }
    }

    public func getCode() -> Int {
        switch self {
        case .SOLAR_DAY: return 0
        case .SOLAR_WEEK: return 1
        case .LUNAR_DAY: return 2
        case .TERM_DAY: return 3
        case .TERM_HS: return 4
        case .TERM_EB: return 5
        }
    }

    public static func fromCode(_ code: Int) -> Self? {
        switch code {
        case 0: return .SOLAR_DAY
        case 1: return .SOLAR_WEEK
        case 2: return .LUNAR_DAY
        case 3: return .TERM_DAY
        case 4: return .TERM_HS
        case 5: return .TERM_EB
        default: return nil
        }
    }

    public static func fromName(_ name: String) -> Self? {
        switch name {
        case "公历日期": return .SOLAR_DAY
        case "几月第几个星期几": return .SOLAR_WEEK
        case "农历日期": return .LUNAR_DAY
        case "节气日期": return .TERM_DAY
        case "节气天干": return .TERM_HS
        case "节气地支": return .TERM_EB
        default: return nil
        }
    }

    public var description: String {
        getName()
    }
}
