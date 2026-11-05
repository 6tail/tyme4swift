import Tyme4Swift
import XCTest

/// 法定节假日测试
final class LegalHolidayTests: XCTestCase {
    func test0() {
        let d = LegalHoliday.fromYmd(2011, 5, 1)
        XCTAssertNotNil(d)
        XCTAssertEqual("2011年5月1日 劳动节(休)", d?.description)

        XCTAssertEqual("2011年5月2日 劳动节(休)", d?.next(1)?.description)
        XCTAssertEqual("2011年6月4日 端午节(休)", d?.next(2)?.description)
        XCTAssertEqual("2011年4月30日 劳动节(休)", d?.next(-1)?.description)
        XCTAssertEqual("2011年4月5日 清明节(休)", d?.next(-2)?.description)
    }

    func test3() {
        let d = LegalHoliday.fromYmd(2001, 12, 29)
        XCTAssertNotNil(d)
        XCTAssertEqual("2001年12月29日 元旦(班)", d?.description)
        XCTAssertNil(d?.next(-1))
    }

    func test4() {
        let d = LegalHoliday.fromYmd(2022, 10, 5)
        XCTAssertNotNil(d)
        XCTAssertEqual("2022年10月5日 国庆节(休)", d?.description)
        XCTAssertEqual("2022年10月4日 国庆节(休)", d?.next(-1)?.description)
        XCTAssertEqual("2022年10月6日 国庆节(休)", d?.next(1)?.description)
    }

    func test5() throws {
        let d = try SolarDay.fromYmd(2010, 10, 1).legalHoliday
        XCTAssertNotNil(d)
        XCTAssertEqual("2010年10月1日 国庆节(休)", d?.description)
    }

    func test2027Holidays() throws {
        let periods: [(month: Int, days: ClosedRange<Int>, name: String, isWork: Bool)] = [
            (1, 1...3, "元旦", false),
            (1, 31...31, "春节", true),
            (2, 5...13, "春节", false),
            (2, 14...14, "春节", true),
            (4, 3...5, "清明节", false),
            (5, 1...5, "劳动节", false),
            (5, 8...8, "劳动节", true),
            (6, 9...9, "端午节", false),
            (9, 15...15, "中秋节", false),
            (9, 26...26, "国庆节", true),
            (10, 1...7, "国庆节", false),
            (10, 9...9, "国庆节", true),
        ]
        let firstDay = try SolarDay.fromYmd(2027, 1, 1)
        for offset in 0..<365 {
            let day = try firstDay.next(offset)
            let holiday = LegalHoliday.fromYmd(day.year, day.month, day.day)
            if let expected = periods.first(where: { $0.month == day.month && $0.days.contains(day.day) }) {
                let actual = try XCTUnwrap(holiday, day.description)
                XCTAssertEqual(expected.name, actual.name, day.description)
                XCTAssertEqual(expected.isWork, actual.isWork, day.description)
                XCTAssertEqual(day.description, actual.day.description)
            } else {
                XCTAssertNil(holiday, day.description)
            }
        }
    }

    func test2027HolidayNavigation() throws {
        let previousYear = try XCTUnwrap(LegalHoliday.fromYmd(2026, 10, 10))
        XCTAssertEqual("2027年1月1日 元旦(休)", previousYear.next(1)?.description)
        XCTAssertEqual("2027年10月9日 国庆节(班)", previousYear.next(34)?.description)

        let firstHoliday = try XCTUnwrap(LegalHoliday.fromYmd(2027, 1, 1))
        XCTAssertEqual("2026年10月10日 国庆节(班)", firstHoliday.next(-1)?.description)
        XCTAssertEqual("2027年1月1日 元旦(休)", firstHoliday.next(0)?.description)
        XCTAssertEqual("2027年1月31日 春节(班)", firstHoliday.next(3)?.description)
        XCTAssertEqual("2027年2月5日 春节(休)", firstHoliday.next(4)?.description)

        let lastHoliday = try XCTUnwrap(LegalHoliday.fromYmd(2027, 10, 9))
        XCTAssertEqual("2026年10月10日 国庆节(班)", lastHoliday.next(-34)?.description)
        XCTAssertNil(lastHoliday.next(1))
    }

    func test2027SolarDayLegalHoliday() throws {
        XCTAssertEqual("2027年2月5日 春节(休)", try SolarDay.fromYmd(2027, 2, 5).legalHoliday?.description)
        XCTAssertEqual("2027年2月14日 春节(班)", try SolarDay.fromYmd(2027, 2, 14).legalHoliday?.description)
        XCTAssertNil(try SolarDay.fromYmd(2027, 2, 15).legalHoliday)
    }
}
