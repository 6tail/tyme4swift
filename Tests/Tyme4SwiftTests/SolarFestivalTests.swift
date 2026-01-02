import Tyme4Swift
import XCTest

/// 公历现代节日测试
final class SolarFestivalTests: XCTestCase {
    func test0() {
        for i in 0 ..< SolarFestival.NAMES.count {
            let f = SolarFestival.fromIndex(2023, i)
            XCTAssertNotNil(f)
            XCTAssertEqual(SolarFestival.NAMES[i], f?.getName())
        }
    }

    func test1() {
        let f = SolarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        for i in 0 ..< SolarFestival.NAMES.count {
            XCTAssertEqual(SolarFestival.NAMES[i], f?.next(i)?.getName())
        }
    }

    func test2() {
        let f = SolarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        XCTAssertEqual("2024年5月1日 五一劳动节", f?.next(13)?.description)
        XCTAssertEqual("2022年8月1日 八一建军节", f?.next(-3)?.description)
    }

    func test3() {
        let f = SolarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        XCTAssertEqual("2022年3月8日 三八妇女节", f?.next(-9)?.description)
    }

    func test4() throws {
        let f = try SolarDay.fromYmd(2010, 1, 1).festival
        XCTAssertNotNil(f)
        XCTAssertEqual("2010年1月1日 元旦", f!.description)
    }

    func test5() throws {
        let f = try SolarDay.fromYmd(2021, 5, 4).festival
        XCTAssertNotNil(f)
        XCTAssertEqual("2021年5月4日 五四青年节", f!.description)
    }

    func test6() {
        XCTAssertNil(try SolarDay.fromYmd(1939, 5, 4).festival)
    }
}
