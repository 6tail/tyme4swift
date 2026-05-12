import Foundation

/// 节日抽象
public class AbstractFestival: AbstractTyme {
    /// 索引
    public private(set) var index: Int
    
    /// 日
    var day: DayUnit
    
    /// 事件
    public private(set) var event: Event

    init(_ index: Int, _ event: Event, _ day: DayUnit) {
        self.index = index
        self.event = event
        self.day = day
    }

    public override func getName() -> String {
        event.getName()
    }

    public override var description: String {
        "\(getDay()) \(getName())"
    }
    
    /// 日
    public func getDay() -> DayUnit {
        day
    }
}
