import Foundation

/// 藏历年(公历1027年为藏历元年，第一饶迥火兔年）
public class RabByungYear: AbstractTyme {
    /// 饶迥(胜生周)序号，从0开始
    public private(set) var rabByungIndex: Int

    /// 干支
    public private(set) var sixtyCycle: SixtyCycle

    required init(_ rabByungIndex: Int, _ sixtyCycle: SixtyCycle) throws {
        try Self.validate(rabByungIndex)
        self.rabByungIndex = rabByungIndex
        self.sixtyCycle = sixtyCycle
    }

    public class func validate(_ rabByungIndex: Int) throws {
        if rabByungIndex < 0 || rabByungIndex > 150 {
            throw ArgumentError("illegal rab-byung index: \(rabByungIndex)")
        }
    }

    public class func fromSixtyCycle(_ rabByungIndex: Int, _ sixtyCycle: SixtyCycle) throws -> Self {
        try Self(rabByungIndex, sixtyCycle)
    }

    public class func fromYear(_ year: Int) throws -> Self {
        try Self((year - 1024) / 60, SixtyCycle.fromIndex(year - 4))
    }

    public class func fromElementZodiac(_ rabByungIndex: Int, _ element: RabByungElement, _ zodiac: Zodiac) throws -> Self {
        for i in 0 ..< 60 {
            let sixtyCycle: SixtyCycle = SixtyCycle.fromIndex(i)
            if sixtyCycle.earthBranch.getZodiac() == zodiac && sixtyCycle.heavenStem.element.index == element.index {
                return try Self(rabByungIndex, sixtyCycle)
            }
        }
        throw ArgumentError("illegal rab-byung element \(element), zodiac \(zodiac)")
    }

    /// 生肖
    public func getZodiac() -> Zodiac {
        sixtyCycle.earthBranch.getZodiac()
    }
    
    /// 公历年
    public func getSolarYear() -> SolarYear {
        try! SolarYear.fromYear(year)
    }

    public override func getName() -> String {
        let digits: [String] = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"]
        let units: [String] = ["", "十", "百"]
        var n: Int = rabByungIndex + 1
        var s: String = ""
        var pos: Int = 0

        while n > 0 {
            let digit: Int = n % 10
            if digit > 0 {
                s = digits[digit] + units[pos] + s
            } else if !s.isEmpty {
                s = digits[digit] + s
            }
            
            n /= 10
            pos += 1
        }

        var letter: String = s
        if letter.hasPrefix("一十") {
            letter = String(letter.dropFirst())
        }

        return "第\(letter)饶迥\(element)\(getZodiac())年"
    }

    public override func next(_ n: Int) throws -> Self {
        try Self.fromYear(year + n)
    }

    /// 五行
    public var element: RabByungElement {
        RabByungElement.fromIndex(sixtyCycle.heavenStem.element.index)
    }

    /// 年
    public var year: Int {
        1024 + rabByungIndex * 60 + sixtyCycle.index
    }
    
    /// 月数
    public var monthCount: Int {
        leapMonth < 1 ? 12 : 13
    }

    /// 闰月，1代表闰1月，0代表无闰月
    public var leapMonth: Int {
        var y: Int = 1
        var m: Int = 4
        var t: Int = 0
        let currentYear: Int = year
        while y < currentYear {
            let i: Int = m - 1 + (t % 2 == 0 ? 33 : 32)
            y = (y * 12 + i) / 12
            m = i % 12 + 1
            t += 1
        }

        return y == currentYear ? m : 0
    }

    /// 首月
    public var firstMonth: RabByungMonth {
        try! RabByungMonth(year: self, month: 1)
    }

    /// 月份列表
    public var months: [RabByungMonth] {
        var l: [RabByungMonth] = [RabByungMonth]()
        let m: Int = leapMonth
        for i: Int in 1 ..< 13 {
            l.append(try! RabByungMonth(year: self, month: i))
            if i == m {
                l.append(try! RabByungMonth(year: self, month: -i))
            }
        }
        return l
    }
}
