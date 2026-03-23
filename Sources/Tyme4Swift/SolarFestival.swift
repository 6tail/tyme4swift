import Foundation

/// 公历现代节日
public class SolarFestival: AbstractTyme {
    public static var NAMES: [String] = ["元旦", "妇女节", "植树节", "劳动节", "青年节", "儿童节", "建党节", "建军节", "教师节", "国庆节"]
    public static var DATA: String = "@00001011950@01003081950@02003121979@03005011950@04005041950@05006011950@06007011941@07008011933@08009101985@09010011950"

    /// 类型
    public private(set) var type: FestivalType

    /// 公历日
    public private(set) var day: SolarDay

    /// 名称
    public private(set) var name: String

    /// 起始年
    public private(set) var startYear: Int

    /// 索引
    public private(set) var index: Int

    required init(type: FestivalType, day: SolarDay, startYear: Int, data: String) {
        self.type = type
        self.day = day
        self.startYear = startYear
        let index: Int = Int(String(data.dropFirst(1).prefix(2)))!
        self.index = index
        name = Self.NAMES[index]
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> Self? {
        let regex: NSRegularExpression = try! NSRegularExpression(pattern: String(format: "@\\d{2}0%02d%02d\\d+", month, day))
        guard let matcher = regex.firstMatch(in: Self.DATA, range: NSRange(Self.DATA.startIndex..., in: Self.DATA)) else {
            return nil
        }
        let data: String = String(Self.DATA[Range(matcher.range, in: Self.DATA)!])
        guard let startYear = Int(String(data.dropFirst(8))) else {
            return nil
        }
        if year < startYear {
            return nil
        }
        guard let solarDay = try? SolarDay.fromYmd(year, month, day) else {
            return nil
        }
        return Self(type: FestivalType.DAY, day: solarDay, startYear: startYear, data: data)
    }

    public class func fromIndex(_ year: Int, _ index: Int) -> Self? {
        if index < 0 || index >= Self.NAMES.count {
            return nil
        }

        let regex: NSRegularExpression = try! NSRegularExpression(pattern: String(format: "@%02d\\d+", index))
        guard let matcher = regex.firstMatch(in: Self.DATA, range: NSRange(Self.DATA.startIndex..., in: Self.DATA)) else {
            return nil
        }

        let data: String = String(Self.DATA[Range(matcher.range, in: Self.DATA)!])
        if Int(data[data.index(data.startIndex, offsetBy: 3)].asciiValue!) - 48 != FestivalType.DAY.getCode() {
            return nil
        }

        let startYear: Int = Int(String(data.dropFirst(8)))!
        if year < startYear {
            return nil
        }

        guard let solarDay = try? SolarDay.fromYmd(year, Int(String(data.dropFirst(4).prefix(2)))!, Int(String(data.dropFirst(6).prefix(2)))!) else {
            return nil
        }

        return Self(type: FestivalType.DAY, day: solarDay, startYear: startYear, data: data)
    }

    public override func next(_ n: Int) -> Self? {
        let size: Int = Self.NAMES.count
        let i: Int = index + n
        return Self.fromIndex((day.year * size + i) / size, indexOf(i, size))
    }

    public override func getName() -> String {
        name
    }

    public override var description: String {
        "\(day) \(name)"
    }
}
