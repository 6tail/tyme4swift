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
}
