import Tyme4Swift
import XCTest

/// 农历日测试
final class LunarDayTests: XCTestCase {
    func test1() {
        XCTAssertEqual("1年1月1日", try LunarDay.fromYmd(0, 11, 18).getSolarDay().description)
    }

    func test2() {
        XCTAssertEqual("9999年12月31日", try LunarDay.fromYmd(9999, 12, 2).getSolarDay().description)
    }

    func test3() {
        XCTAssertEqual("1905年2月4日", try LunarDay.fromYmd(1905, 1, 1).getSolarDay().description)
    }

    func test4() {
        XCTAssertEqual("2039年1月23日", try LunarDay.fromYmd(2038, 12, 29).getSolarDay().description)
    }

    func test5() {
        XCTAssertEqual("1500年1月31日", try LunarDay.fromYmd(1500, 1, 1).getSolarDay().description)
    }

    func test6() {
        XCTAssertEqual("1501年1月18日", try LunarDay.fromYmd(1500, 12, 29).getSolarDay().description)
    }

    func test7() {
        XCTAssertEqual("1582年10月4日", try LunarDay.fromYmd(1582, 9, 18).getSolarDay().description)
    }

    func test8() {
        XCTAssertEqual("1582年10月15日", try LunarDay.fromYmd(1582, 9, 19).getSolarDay().description)
    }

    func test9() {
        XCTAssertEqual("2020年1月6日", try LunarDay.fromYmd(2019, 12, 12).getSolarDay().description)
    }

    func test10() {
        XCTAssertEqual("2033年12月22日", try LunarDay.fromYmd(2033, -11, 1).getSolarDay().description)
    }

    func test11() {
        XCTAssertEqual("2021年7月16日", try LunarDay.fromYmd(2021, 6, 7).getSolarDay().description)
    }

    func test12() {
        XCTAssertEqual("2034年2月19日", try LunarDay.fromYmd(2034, 1, 1).getSolarDay().description)
    }

    func test13() {
        XCTAssertEqual("2034年1月20日", try LunarDay.fromYmd(2033, 12, 1).getSolarDay().description)
    }

    func test14() {
        XCTAssertEqual("7013年12月24日", try LunarDay.fromYmd(7013, -11, 4).getSolarDay().description)
    }

    func test15() {
        XCTAssertEqual("己亥", try LunarDay.fromYmd(2023, 8, 24).sixtyCycle.description)
    }

    func test16() {
        XCTAssertEqual("癸酉", try LunarDay.fromYmd(1653, 1, 6).sixtyCycle.description)
    }

    func test17() {
        XCTAssertEqual("农历庚寅年二月初二", try LunarDay.fromYmd(2010, 1, 1).next(31).description)
    }

    func test18() {
        XCTAssertEqual("农历壬辰年闰四月初一", try LunarDay.fromYmd(2012, 3, 1).next(60).description)
    }

    func test19() {
        XCTAssertEqual("农历壬辰年闰四月廿九", try LunarDay.fromYmd(2012, 3, 1).next(88).description)
    }

    func test20() {
        XCTAssertEqual("农历壬辰年五月初一", try LunarDay.fromYmd(2012, 3, 1).next(89).description)
    }

    func test21() {
        XCTAssertEqual("2020年4月23日", try LunarDay.fromYmd(2020, 4, 1).getSolarDay().description)
    }

    func test22() {
        XCTAssertEqual("甲辰", try LunarDay.fromYmd(2024, 1, 1).lunarMonth.lunarYear.sixtyCycle.getName())
    }

    func test23() {
        XCTAssertEqual("癸卯", try LunarDay.fromYmd(2023, 12, 30).lunarMonth.lunarYear.sixtyCycle.getName())
    }

    /// 二十八宿
    func test24() throws {
        let d = try LunarDay.fromYmd(2020, 4, 13)
        let star = d.twentyEightStar
        XCTAssertEqual("南", star.zone.getName())
        XCTAssertEqual("朱雀", star.zone.getBeast().getName())
        XCTAssertEqual("翼", star.getName())
        XCTAssertEqual("火", star.sevenStar.getName())
        XCTAssertEqual("蛇", star.getAnimal().getName())
        XCTAssertEqual("凶", star.luck.getName())

        XCTAssertEqual("阳天", star.land.getName())
        XCTAssertEqual("东南", star.land.getDirection().getName())
    }

    func test25() throws {
        let d = try LunarDay.fromYmd(2023, 9, 28)
        let star = d.twentyEightStar
        XCTAssertEqual("南", star.zone.getName())
        XCTAssertEqual("朱雀", star.zone.getBeast().getName())
        XCTAssertEqual("柳", star.getName())
        XCTAssertEqual("土", star.sevenStar.getName())
        XCTAssertEqual("獐", star.getAnimal().getName())
        XCTAssertEqual("凶", star.luck.getName())

        XCTAssertEqual("炎天", star.land.getName())
        XCTAssertEqual("南", star.land.getDirection().getName())
    }

    func test26() throws {
        let lunar = try LunarDay.fromYmd(2005, 11, 23)
        XCTAssertEqual("戊子", lunar.lunarMonth.sixtyCycle.getName())
        XCTAssertEqual("戊子", lunar.getSixtyCycleDay().month.getName())
    }

    func test28() throws {
        let lunar = try LunarDay.fromYmd(2024, 3, 5)
        XCTAssertEqual("大安", lunar.minorRen.getName())
    }
}
