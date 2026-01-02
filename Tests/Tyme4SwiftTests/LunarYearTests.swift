import Tyme4Swift
import XCTest

/// 农历年测试
final class LunarYearTests: XCTestCase {
    func test0() {
        XCTAssertEqual("农历癸卯年", try LunarYear.fromYear(2023).getName())
    }

    func test1() {
        XCTAssertEqual("农历戊申年", try LunarYear.fromYear(2023).next(5).getName())
    }

    func test2() {
        XCTAssertEqual("农历戊戌年", try LunarYear.fromYear(2023).next(-5).getName())
    }

    /// 农历年的干支
    func test3() {
        XCTAssertEqual("庚子", try LunarYear.fromYear(2020).sixtyCycle.getName())
    }

    /// 农历年的生肖(农历年.干支.地支.生肖)
    func test4() {
        XCTAssertEqual("虎", try LunarYear.fromYear(1986).sixtyCycle.earthBranch.getZodiac().getName())
    }

    func test5() {
        XCTAssertEqual(12, try LunarYear.fromYear(151).leapMonth)
    }

    func test6() {
        XCTAssertEqual(1, try LunarYear.fromYear(2357).leapMonth)
    }

    func test7() throws {
        let y = try LunarYear.fromYear(2023)
        XCTAssertEqual("癸卯", y.sixtyCycle.getName())
        XCTAssertEqual("兔", y.sixtyCycle.earthBranch.getZodiac().getName())
    }

    func test8() {
        XCTAssertEqual("上元", try LunarYear.fromYear(1864).twenty.sixty.getName())
    }

    func test9() {
        XCTAssertEqual("上元", try LunarYear.fromYear(1923).twenty.sixty.getName())
    }

    func test10() {
        XCTAssertEqual("中元", try LunarYear.fromYear(1924).twenty.sixty.getName())
    }

    func test11() {
        XCTAssertEqual("中元", try LunarYear.fromYear(1983).twenty.sixty.getName())
    }

    func test12() {
        XCTAssertEqual("下元", try LunarYear.fromYear(1984).twenty.sixty.getName())
    }

    func test13() {
        XCTAssertEqual("下元", try LunarYear.fromYear(2043).twenty.sixty.getName())
    }

    func test14() {
        XCTAssertEqual("一运", try LunarYear.fromYear(1864).twenty.getName())
    }

    func test15() {
        XCTAssertEqual("一运", try LunarYear.fromYear(1883).twenty.getName())
    }

    func test16() {
        XCTAssertEqual("二运", try LunarYear.fromYear(1884).twenty.getName())
    }

    func test17() {
        XCTAssertEqual("二运", try LunarYear.fromYear(1903).twenty.getName())
    }

    func test18() {
        XCTAssertEqual("三运", try LunarYear.fromYear(1904).twenty.getName())
    }

    func test19() {
        XCTAssertEqual("三运", try LunarYear.fromYear(1923).twenty.getName())
    }

    func test20() {
        XCTAssertEqual("八运", try LunarYear.fromYear(2004).twenty.getName())
    }

    func test21() throws {
        let year = try LunarYear.fromYear(1)
        XCTAssertEqual("六运", year.twenty.getName())
        XCTAssertEqual("中元", year.twenty.sixty.getName())
    }

    func test22() throws {
        let year = try LunarYear.fromYear(1863)
        XCTAssertEqual("九运", year.twenty.getName())
        XCTAssertEqual("下元", year.twenty.sixty.getName())
    }
}
