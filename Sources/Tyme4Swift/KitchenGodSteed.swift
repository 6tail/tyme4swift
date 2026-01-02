import Foundation

/// 灶马头
public class KitchenGodSteed: AbstractCulture {
    public static var NUMBERS: [String] = ["一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"]
    
    /// 正月初一的干支
    public private(set) var firstDaySixtyCycle: SixtyCycle
    
    required init(_ lunarYear: Int) throws {
        try self.firstDaySixtyCycle = LunarDay.fromYmd(lunarYear, 1, 1).sixtyCycle
    }
  
    public class func fromLunarYear(_ lunarYear: Int) throws -> Self {
        try Self(lunarYear)
    }
    
    public override func getName() -> String {
        "灶马头"
    }
    
    func byHeavenStem(_ n: Int) -> String {
        Self.NUMBERS[firstDaySixtyCycle.heavenStem.stepsTo(n)]
    }
 
    func byEarthBranch(_ n: Int) -> String {
        Self.NUMBERS[firstDaySixtyCycle.earthBranch.stepsTo(n)]
    }
    
    /// 几鼠偷粮
    public var mouse: String {
        "\(byEarthBranch(0))鼠偷粮"
    }
    
    /// 草子几分
    public var grass: String {
        "草子\(byEarthBranch(0))分"
    }
    
    /// 几牛耕田
    public var Cattle: String {
        "\(byEarthBranch(1))牛耕田"
    }
    
    /// 花收几分
    public var Flower: String {
        "花收\(byEarthBranch(3))分"
    }
    
    /// 几龙治水
    public var Dragon: String {
        "\(byEarthBranch(4))龙治水"
    }
    
    /// 几马驮谷
    public var Horse: String {
        "\(byEarthBranch(6))马驮谷"
    }
    
    /// 几鸡抢米
    public var Chicken: String {
        "\(byEarthBranch(9))鸡抢米"
    }
    
    /// 几姑看蚕
    public var Silkworm: String {
        "\(byEarthBranch(9))姑看蚕"
    }
    
    /// 几屠共猪
    public var Pig: String {
        "\(byEarthBranch(11))屠共猪"
    }
    
    /// 甲田几分
    public var Field: String {
        "甲田\(byHeavenStem(0))分"
    }
    
    /// 几人分饼
    public var Cake: String {
        "\(byHeavenStem(2))人分饼"
    }
    
    /// 几日得金
    public var Gold: String {
        "\(byHeavenStem(7))日得金"
    }
    
    /// 几人几丙
    public var PeopleCakes: String {
        "\(byEarthBranch(2))人\(byHeavenStem(2))丙"
    }
    
    /// 几人几锄
    public var PeopleHoes: String {
        "\(byEarthBranch(2))人\(byHeavenStem(3))锄"
    }
}
