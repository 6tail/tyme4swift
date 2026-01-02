import Tyme4Swift
import XCTest

/// 农历月测试
final class LunarMonthTests: XCTestCase {
    func test0() {
        XCTAssertEqual("七月", try LunarMonth.fromYm(2359, 7).getName())
    }

    /// 闰月
    func test1() {
        XCTAssertEqual("闰七月", try LunarMonth.fromYm(2359, -7).getName())
    }

    func test2() {
        XCTAssertEqual(29, try LunarMonth.fromYm(2023, 6).dayCount)
    }

    func test3() {
        XCTAssertEqual(30, try LunarMonth.fromYm(2023, 7).dayCount)
    }

    func test4() {
        XCTAssertEqual(30, try LunarMonth.fromYm(2023, 8).dayCount)
    }

    func test5() {
        XCTAssertEqual(29, try LunarMonth.fromYm(2023, 9).dayCount)
    }

    func test6() {
        XCTAssertEqual("2023年10月15日", try LunarMonth.fromYm(2023, 9).firstJulianDay.getSolarDay().description)
    }

    func test7() {
        XCTAssertEqual("甲寅", try LunarMonth.fromYm(2023, 1).sixtyCycle.getName())
    }

    func test8() {
        XCTAssertEqual("乙卯", try LunarMonth.fromYm(2023, -2).sixtyCycle.getName())
    }

    func test9() {
        XCTAssertEqual("丙辰", try LunarMonth.fromYm(2023, 3).sixtyCycle.getName())
    }

    func test10() {
        XCTAssertEqual("丙寅", try LunarMonth.fromYm(2024, 1).sixtyCycle.getName())
    }

    func test11() {
        XCTAssertEqual("乙丑", try LunarMonth.fromYm(2023, 12).sixtyCycle.getName())
    }

    func test12() {
        XCTAssertEqual("壬寅", try LunarMonth.fromYm(2022, 1).sixtyCycle.getName())
    }

    func test13() {
        XCTAssertEqual("闰十二月", try LunarMonth.fromYm(37, -12).getName())
    }

    func test14() {
        XCTAssertEqual("闰十二月", try LunarMonth.fromYm(5552, -12).getName())
    }

    func test15() {
        XCTAssertEqual("农历戊子年十二月", try LunarMonth.fromYm(2008, 11).next(1).description)
    }

    func test16() {
        XCTAssertEqual("农历己丑年正月", try LunarMonth.fromYm(2008, 11).next(2).description)
    }

    func test17() {
        XCTAssertEqual("农历己丑年五月", try LunarMonth.fromYm(2008, 11).next(6).description)
    }

    func test18() {
        XCTAssertEqual("农历己丑年闰五月", try LunarMonth.fromYm(2008, 11).next(7).description)
    }

    func test19() {
        XCTAssertEqual("农历己丑年六月", try LunarMonth.fromYm(2008, 11).next(8).description)
    }

    func test20() {
        XCTAssertEqual("农历庚寅年正月", try LunarMonth.fromYm(2008, 11).next(15).description)
    }

    func test21() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2008, 12).next(-1).description)
    }

    func test22() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2009, 1).next(-2).description)
    }

    func test23() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2009, 5).next(-6).description)
    }

    func test24() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2009, -5).next(-7).description)
    }

    func test25() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2009, 6).next(-8).description)
    }

    func test26() {
        XCTAssertEqual("农历戊子年十一月", try LunarMonth.fromYm(2010, 1).next(-15).description)
    }

    func test27() {
        XCTAssertEqual(29, try LunarMonth.fromYm(2012, -4).dayCount)
    }

    func test28() {
        XCTAssertEqual("壬戌", try LunarMonth.fromYm(2023, 9).sixtyCycle.description)
    }

    func test29() throws {
        let d = try SolarDay.fromYmd(2023, 10, 7).getLunarDay()
        XCTAssertEqual("辛酉", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("辛酉", d.getSixtyCycleDay().month.description)
    }

    func test30() throws {
        let d = try SolarDay.fromYmd(2023, 10, 8).getLunarDay()
        XCTAssertEqual("辛酉", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("壬戌", d.getSixtyCycleDay().month.description)
    }

    func test31() throws {
        let d = try SolarDay.fromYmd(2023, 10, 15).getLunarDay()
        XCTAssertEqual("九月", d.lunarMonth.getName())
        XCTAssertEqual("壬戌", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("壬戌", d.getSixtyCycleDay().month.description)
    }

    func test32() throws {
        let d = try SolarDay.fromYmd(2023, 11, 7).getLunarDay()
        XCTAssertEqual("壬戌", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("壬戌", d.getSixtyCycleDay().month.description)
    }

    func test33() throws {
        let d = try SolarDay.fromYmd(2023, 11, 8).getLunarDay()
        XCTAssertEqual("壬戌", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("癸亥", d.getSixtyCycleDay().month.description)
    }

    func test34() throws {
        // 2023年闰2月
        let m = try LunarMonth.fromYm(2023, 12)
        XCTAssertEqual("农历癸卯年十二月", m.description)
        XCTAssertEqual("农历癸卯年十一月", try m.next(-1).description)
        XCTAssertEqual("农历癸卯年十月", try m.next(-2).description)
    }

    func test35() throws {
        // 2023年闰2月
        let m = try LunarMonth.fromYm(2023, 3)
        XCTAssertEqual("农历癸卯年三月", m.description)
        XCTAssertEqual("农历癸卯年闰二月", try m.next(-1).description)
        XCTAssertEqual("农历癸卯年二月", try m.next(-2).description)
        XCTAssertEqual("农历癸卯年正月", try m.next(-3).description)
        XCTAssertEqual("农历壬寅年十二月", try m.next(-4).description)
        XCTAssertEqual("农历壬寅年十一月", try m.next(-5).description)
    }

    func test36() throws {
        let d = try SolarDay.fromYmd(1983, 2, 15).getLunarDay()
        XCTAssertEqual("甲寅", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("甲寅", d.getSixtyCycleDay().month.description)
    }

    func test37() throws {
        let d = try SolarDay.fromYmd(2023, 10, 30).getLunarDay()
        XCTAssertEqual("壬戌", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("壬戌", d.getSixtyCycleDay().month.description)
    }

    func test38() throws {
        let d = try SolarDay.fromYmd(2023, 10, 19).getLunarDay()
        XCTAssertEqual("壬戌", d.lunarMonth.sixtyCycle.description)
        XCTAssertEqual("壬戌", d.getSixtyCycleDay().month.description)
    }

    func test39() throws {
        let m = try LunarMonth.fromYm(2023, 11)
        XCTAssertEqual("农历癸卯年十一月", m.description)
        XCTAssertEqual("甲子", m.sixtyCycle.description)
    }

    func test40() throws {
        XCTAssertEqual("庚申", try LunarDay.fromYmd(2018, 6, 26).getSixtyCycleDay().month.description)
    }

    func test41() throws {
        XCTAssertEqual("辛丑", try LunarMonth.fromYm(1991, 12).sixtyCycle.description)
    }
}
