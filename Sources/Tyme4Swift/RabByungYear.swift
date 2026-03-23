import Foundation

/// 藏历年(公历1027年为藏历元年，第一饶迥火兔年）
public class RabByungYear: AbstractTyme {
    /// 饶迥(胜生周)序号，从0开始
    public private(set) var rabByungIndex: Int

    /// 五行索引，从0开始
    public private(set) var elementIndex: Int
    
    /// 生肖索引，从0开始
    public private(set) var zodiacIndex: Int
    
    public class func validate(_ year: Int) throws {
        if year < 1027 || year > 9999 {
            throw ArgumentError("illegal rab-byung year: \(year)")
        }
    }

    required init(_ rabByungIndex: Int, _ elementIndex: Int, _ zodiacIndex: Int) throws {
        if rabByungIndex < 0 || rabByungIndex > 150 {
            throw ArgumentError("illegal rab-byung index: \(rabByungIndex)")
        }
        if elementIndex < 0 || elementIndex >= Element.NAMES.count {
            throw ArgumentError("illegal element index: \(elementIndex)")
        }
        if zodiacIndex < 0 || zodiacIndex >= Zodiac.NAMES.count {
            throw ArgumentError("illegal zodiac index: \(zodiacIndex)")
        }
        self.rabByungIndex = rabByungIndex
        self.elementIndex = elementIndex
        self.zodiacIndex = zodiacIndex
    }

    public class func fromSixtyCycle(_ rabByungIndex: Int, _ sixtyCycle: SixtyCycle) throws -> Self {
        try Self(rabByungIndex, sixtyCycle.heavenStem.element.index, sixtyCycle.earthBranch.getZodiac().index)
    }

    public class func fromYear(_ year: Int) throws -> Self {
        try validate(year)
        return try fromSixtyCycle((year - 1024) / 60, SixtyCycle.fromIndex(year - 4))
    }

    public class func fromElementZodiac(_ rabByungIndex: Int, _ element: RabByungElement, _ zodiac: Zodiac) throws -> Self {
        try Self(rabByungIndex, element.index, zodiac.index)
    }

    /// 生肖
    public func getZodiac() -> Zodiac {
        Zodiac.fromIndex(zodiacIndex)
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
    
    /// 干支
    public var sixtyCycle: SixtyCycle {
        SixtyCycle.fromIndex(6 * (elementIndex * 2 + zodiacIndex % 2) - 5 * zodiacIndex)
    }

    /// 五行
    public var element: RabByungElement {
        RabByungElement.fromIndex(elementIndex)
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
        var t: Int = 1
        let currentYear: Int = year
        while y < currentYear {
            let i: Int = m + 31 + t
            y += 2
            m = i - 23
            if i > 35 {
                y += 1
                m -= 12
            }
            t = 1 - t
        }

        return y == currentYear ? m : 0
    }

    /// 首月
    public var firstMonth: RabByungMonth {
        try! RabByungMonth(year, 1)
    }

    /// 月份列表
    public var months: [RabByungMonth] {
        var l: [RabByungMonth] = [RabByungMonth]()
        let y: Int = year
        let m: Int = leapMonth
        for i: Int in 1 ..< 13 {
            l.append(try! RabByungMonth(y, i))
            if i == m {
                l.append(try! RabByungMonth(y, -i))
            }
        }
        return l
    }
}
