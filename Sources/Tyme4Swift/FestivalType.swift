/// 节日类型
public enum FestivalType: Int {
    case DAY = 0
    case TERM = 1
    case EVE = 2

    public func getName() -> String {
        switch self {
        case .DAY:
            return "日期"
        case .TERM:
            return "节气"
        case .EVE:
            return "除夕"
        }
    }
    
    public func getCode() -> Int {
        switch self {
        case .DAY:
            return 0
        case .TERM:
            return 1
        case .EVE:
            return 2
        }
    }
    
    public static func fromCode(_ code: Int) -> Self? {
        if code == 0 {
            return .DAY
        }
        if code == 1 {
            return .TERM
        }
        if code == 2 {
            return .EVE
        }
        return nil
    }

    public static func fromName(_ name: String) -> Self? {
        if name == "日期" {
            return .DAY
        }
        if name == "节气" {
            return .TERM
        }
        if name == "除夕" {
            return .EVE
        }
        return nil
    }
    
    public var description: String {
        getName()
    }
}
