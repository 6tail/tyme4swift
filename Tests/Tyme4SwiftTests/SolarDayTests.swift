import Tyme4Swift
import XCTest

/// 公历日测试
final class SolarDayTests: XCTestCase {
    func test0() {
        XCTAssertEqual("1日", try SolarDay.fromYmd(2023, 1, 1).getName())
        XCTAssertEqual("2023年1月1日", try SolarDay.fromYmd(2023, 1, 1).description)
    }

    func test1() {
        XCTAssertEqual("29日", try SolarDay.fromYmd(2000, 2, 29).getName())
        XCTAssertEqual("2000年2月29日", try SolarDay.fromYmd(2000, 2, 29).description)
    }

    func test2() {
        XCTAssertEqual(0, try SolarDay.fromYmd(2023, 1, 1).indexInYear)
        XCTAssertEqual(364, try SolarDay.fromYmd(2023, 12, 31).indexInYear)
        XCTAssertEqual(365, try SolarDay.fromYmd(2020, 12, 31).indexInYear)
    }

    func test3() {
        XCTAssertEqual(0, try SolarDay.fromYmd(2023, 1, 1).subtract(SolarDay.fromYmd(2023, 1, 1)))
        XCTAssertEqual(1, try SolarDay.fromYmd(2023, 1, 2).subtract(SolarDay.fromYmd(2023, 1, 1)))
        XCTAssertEqual(-1, try SolarDay.fromYmd(2023, 1, 1).subtract(SolarDay.fromYmd(2023, 1, 2)))
        XCTAssertEqual(31, try SolarDay.fromYmd(2023, 2, 1).subtract(SolarDay.fromYmd(2023, 1, 1)))
        XCTAssertEqual(-31, try SolarDay.fromYmd(2023, 1, 1).subtract(SolarDay.fromYmd(2023, 2, 1)))
        XCTAssertEqual(365, try SolarDay.fromYmd(2024, 1, 1).subtract(SolarDay.fromYmd(2023, 1, 1)))
        XCTAssertEqual(-365, try SolarDay.fromYmd(2023, 1, 1).subtract(SolarDay.fromYmd(2024, 1, 1)))
        XCTAssertEqual(1, try SolarDay.fromYmd(1582, 10, 15).subtract(SolarDay.fromYmd(1582, 10, 4)))
    }

    func test4() {
        XCTAssertEqual("1582年10月4日", try SolarDay.fromYmd(1582, 10, 15).next(-1).description)
    }

    func test5() {
        XCTAssertEqual("2000年3月1日", try SolarDay.fromYmd(2000, 2, 28).next(2).description)
    }

    func test6() {
        XCTAssertEqual("农历庚子年闰四月初二", try SolarDay.fromYmd(2020, 5, 24).getLunarDay().description)
    }

    func test7() {
        XCTAssertEqual(31, try SolarDay.fromYmd(2020, 5, 24).subtract(SolarDay.fromYmd(2020, 4, 23)))
    }

    func test8() {
        XCTAssertEqual("农历丙子年十一月十二", try SolarDay.fromYmd(16, 11, 30).getLunarDay().description)
    }

    func test9() {
        XCTAssertEqual("霜降", try SolarDay.fromYmd(2023, 10, 27).term.description)
    }

    func test10() {
        XCTAssertEqual("豺乃祭兽第4天", try SolarDay.fromYmd(2023, 10, 27).phenologyDay.description)
    }

    func test11() {
        XCTAssertEqual("初候", try SolarDay.fromYmd(2023, 10, 27).phenologyDay.phenology.threePhenology.description)
    }

    func test22() {
        XCTAssertEqual("甲辰", try SolarDay.fromYmd(2024, 2, 10).getLunarDay().lunarMonth.lunarYear.sixtyCycle.getName())
    }

    func test23() {
        XCTAssertEqual("癸卯", try SolarDay.fromYmd(2024, 2, 9).getLunarDay().lunarMonth.lunarYear.sixtyCycle.getName())
    }
}
