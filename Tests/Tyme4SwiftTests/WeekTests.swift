import Tyme4Swift
import XCTest

/// 星期测试
final class WeekTests: XCTestCase {
    func test0() {
        XCTAssertEqual("一", try SolarDay.fromYmd(1582, 10, 1).week.getName())
    }

    func test1() {
        XCTAssertEqual("五", try SolarDay.fromYmd(1582, 10, 15).week.getName())
    }

    func test2() {
        XCTAssertEqual(2, try SolarDay.fromYmd(2023, 10, 31).week.index)
    }

    func test3() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0)
        XCTAssertEqual("第一周", w.getName())
        XCTAssertEqual("2023年10月第一周", w.description)
    }

    func test5() throws {
        let w = try SolarWeek.fromYm(2023, 10, 4, 0)
        XCTAssertEqual("第五周", w.getName())
        XCTAssertEqual("2023年10月第五周", w.description)
    }

    func test6() throws {
        let w = try SolarWeek.fromYm(2023, 10, 5, 1)
        XCTAssertEqual("第六周", w.getName())
        XCTAssertEqual("2023年10月第六周", w.description)
    }

    func test7() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0).next(4)
        XCTAssertEqual("第五周", w.getName())
        XCTAssertEqual("2023年10月第五周", w.description)
    }

    func test8() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0).next(5)
        XCTAssertEqual("第二周", w.getName())
        XCTAssertEqual("2023年11月第二周", w.description)
    }

    func test9() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0).next(-1)
        XCTAssertEqual("第五周", w.getName())
        XCTAssertEqual("2023年9月第五周", w.description)
    }

    func test10() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0).next(-5)
        XCTAssertEqual("第一周", w.getName())
        XCTAssertEqual("2023年9月第一周", w.description)
    }

    func test11() throws {
        let w = try SolarWeek.fromYm(2023, 10, 0, 0).next(-6)
        XCTAssertEqual("第四周", w.getName())
        XCTAssertEqual("2023年8月第四周", w.description)
    }

    func test12() throws {
        let solar = try SolarDay.fromYmd(1582, 10, 1)
        XCTAssertEqual(1, solar.week.index)
    }

    func test13() throws {
        let solar = try SolarDay.fromYmd(1582, 10, 15)
        XCTAssertEqual(5, solar.week.index)
    }

    func test14() throws {
        let solar = try SolarDay.fromYmd(1129, 11, 17)
        XCTAssertEqual(0, solar.week.index)
    }

    func test15() throws {
        let solar = try SolarDay.fromYmd(1129, 11, 1)
        XCTAssertEqual(5, solar.week.index)
    }

    func test16() throws {
        let solar = try SolarDay.fromYmd(8, 11, 1)
        XCTAssertEqual(4, solar.week.index)
    }

    func test17() throws {
        let solar = try SolarDay.fromYmd(1582, 9, 30)
        XCTAssertEqual(0, solar.week.index)
    }

    func test18() throws {
        let solar = try SolarDay.fromYmd(1582, 1, 1)
        XCTAssertEqual(1, solar.week.index)
    }

    func test19() throws {
        let solar = try SolarDay.fromYmd(1500, 2, 29)
        XCTAssertEqual(6, solar.week.index)
    }

    func test20() throws {
        let solar = try SolarDay.fromYmd(9865, 7, 26)
        XCTAssertEqual(3, solar.week.index)
    }

    func test21() throws {
        let week = try LunarWeek.fromYm(2023, 1, 0, 2)
        XCTAssertEqual("农历癸卯年正月第一周", week.description)
        XCTAssertEqual("农历壬寅年十二月廿六", week.firstDay.description)
    }

    func test22() throws {
        let week = try SolarWeek.fromYm(2023, 1, 0, 2)
        XCTAssertEqual("2023年1月第一周", week.description)
        XCTAssertEqual("2022年12月27日", week.firstDay.description)
    }

    func test24() throws {
        let start = 0
        let week = try SolarWeek.fromYm(2024, 2, 2, start)
        XCTAssertEqual("2024年2月第三周", week.description)
        XCTAssertEqual(6, week.indexInYear)

        let week1 = try SolarDay.fromYmd(2024, 2, 11).getSolarWeek(start)
        XCTAssertEqual("2024年2月第三周", week1.description)

        let week2 = try SolarDay.fromYmd(2024, 2, 17).getSolarWeek(start)
        XCTAssertEqual("2024年2月第三周", week2.description)

        let week3 = try SolarDay.fromYmd(2024, 2, 10).getSolarWeek(start)
        XCTAssertEqual("2024年2月第二周", week3.description)

        let week4 = try SolarDay.fromYmd(2024, 2, 18).getSolarWeek(start)
        XCTAssertEqual("2024年2月第四周", week4.description)
    }

    func test25() throws {
        var week = try SolarDay.fromYmd(2024, 7, 1).getSolarWeek(0)
        XCTAssertEqual("2024年7月第一周", week.description)
        XCTAssertEqual(26, week.indexInYear)

        week = try week.next(1)
        XCTAssertEqual("2024年7月第二周", week.description)
    }
}
