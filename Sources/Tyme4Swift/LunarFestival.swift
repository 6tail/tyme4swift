import Foundation

/// 农历传统节日（依据国家标准《农历的编算和颁行》GB/T 33661-2017）
public class LunarFestival: AbstractTyme {
    public static var NAMES: [String] = ["春节", "元宵节", "龙头节", "上巳节", "清明节", "端午节", "七夕节", "中元节", "中秋节", "重阳节", "冬至节", "腊八节", "除夕"]
    public static var DATA: String = "@0000101@0100115@0200202@0300303@04107@0500505@0600707@0700715@0800815@0900909@10124@1101208@122"

    /// 类型
    public private(set) var type: FestivalType

    /// 农历日
    public private(set) var day: LunarDay

    /// 名称
    public private(set) var name: String

    /// 节气
    public private(set) var solarTerm: SolarTerm?

    /// 索引
    public private(set) var index: Int

    required init(type: FestivalType, day: LunarDay, term: SolarTerm?, data: String) {
        self.type = type
        self.day = day
        solarTerm = term
        let index: Int = Int(String(data.dropFirst(1).prefix(2)))!
        self.index = index
        name = Self.NAMES[index]
    }

    public class func fromYmd(_ year: Int, _ month: Int, _ day: Int) -> Self? {
        var regex: NSRegularExpression = try! NSRegularExpression(pattern: String(format: "@\\d{2}0%02d%02d", month, day))
        if let matcher = regex.firstMatch(in: Self.DATA, range: NSRange(Self.DATA.startIndex..., in: Self.DATA)) {
            guard let d = try? LunarDay.fromYmd(year, month, day) else {
                return nil
            }
            return Self(type: FestivalType.DAY, day: d, term: nil, data: String(Self.DATA[Range(matcher.range, in: Self.DATA)!]))
        }
        guard let lunarDay = try? LunarDay.fromYmd(year, month, day) else {
            return nil
        }
        let solarDay: SolarDay = lunarDay.getSolarDay()

        regex = try! NSRegularExpression(pattern: "@\\d{2}1\\d{2}")
        let matches = regex.matches(in: Self.DATA, range: NSRange(Self.DATA.startIndex..., in: Self.DATA))
        for matcher in matches {
            let data: String = String(Self.DATA[Range(matcher.range, in: Self.DATA)!])
            let term: SolarTerm = SolarTerm.fromIndex(year, Int(String(data.dropFirst(4)))!)
            let termDay: SolarDay = term.getSolarDay()
            if termDay.year == solarDay.year && termDay.month == solarDay.month && termDay.day == solarDay.day {
                return Self(type: FestivalType.TERM, day: lunarDay, term: term, data: data)
            }
        }

        if abs(month) == 12 && day > 28 {
            regex = try! NSRegularExpression(pattern: "@\\d{2}2")
            if let matcher = regex.firstMatch(in: Self.DATA, range: NSRange(Self.DATA.startIndex..., in: Self.DATA)) {
                guard let nextDay = try? lunarDay.next(1) else {
                    return nil
                }
                if nextDay.year != year {
                    return Self(type: FestivalType.EVE, day: lunarDay, term: nil, data: String(Self.DATA[Range(matcher.range, in: Self.DATA)!]))
                }
            }
        }
        return nil
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
        let type: Int = Int(data[data.index(data.startIndex, offsetBy: 3)].asciiValue!) - 48
        if type == FestivalType.DAY.getCode() {
            guard let d = try? LunarDay.fromYmd(year, Int(String(data.dropFirst(4).prefix(2)))!, Int(String(data.dropFirst(6).prefix(2)))!) else {
                return nil
            }
            return Self(type: FestivalType.DAY, day: d, term: nil, data: data)
        } else if type == FestivalType.TERM.getCode() {
            let term = SolarTerm.fromIndex(year, Int(String(data.dropFirst(4)))!)
            return Self(type: FestivalType.TERM, day: term.getSolarDay().getLunarDay(), term: term, data: data)
        } else if type == FestivalType.EVE.getCode() {
            guard let d = try? LunarDay.fromYmd(year + 1, 1, 1).next(-1) else {
                return nil
            }
            return Self(type: FestivalType.EVE, day: d, term: nil, data: data)
        }
        return nil
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
