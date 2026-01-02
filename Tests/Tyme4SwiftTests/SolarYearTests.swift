import Tyme4Swift
import XCTest

/// 公历年测试
final class SolarYearTests: XCTestCase {
    func test0() {
        XCTAssertEqual("2023年", try SolarYear.fromYear(2023).getName())
    }

    func test1() {
        XCTAssertFalse(try SolarYear.fromYear(2023).isLeap)
    }

    func test2() {
        XCTAssertTrue(try SolarYear.fromYear(1500).isLeap)
    }

    func test3() {
        XCTAssertFalse(try SolarYear.fromYear(1700).isLeap)
    }

    func test4() {
        XCTAssertEqual(365, try SolarYear.fromYear(2023).dayCount)
    }

    func test5() {
        XCTAssertEqual("2028年", try SolarYear.fromYear(2023).next(5).getName())
    }

    func test6() {
        XCTAssertEqual("2018年", try SolarYear.fromYear(2023).next(-5).getName())
    }
}
