import Tyme4Swift
import XCTest

/// 公历半年测试
final class SolarHalfYearTests: XCTestCase {
    func test0() {
        XCTAssertEqual("上半年", try SolarHalfYear.fromIndex(2023, 0).getName())
        XCTAssertEqual("2023年上半年", try SolarHalfYear.fromIndex(2023, 0).description)
    }

    func test1() {
        XCTAssertEqual("下半年", try SolarHalfYear.fromIndex(2023, 1).getName())
        XCTAssertEqual("2023年下半年", try SolarHalfYear.fromIndex(2023, 1).description)
    }

    func test2() {
        XCTAssertEqual("下半年", try SolarHalfYear.fromIndex(2023, 0).next(1).getName())
        XCTAssertEqual("2023年下半年", try SolarHalfYear.fromIndex(2023, 0).next(1).description)
    }

    func test3() {
        XCTAssertEqual("上半年", try SolarHalfYear.fromIndex(2023, 0).next(2).getName())
        XCTAssertEqual("2024年上半年", try SolarHalfYear.fromIndex(2023, 0).next(2).description)
    }

    func test4() {
        XCTAssertEqual("上半年", try SolarHalfYear.fromIndex(2023, 0).next(-2).getName())
        XCTAssertEqual("2022年上半年", try SolarHalfYear.fromIndex(2023, 0).next(-2).description)
    }

    func test5() {
        XCTAssertEqual("2021年上半年", try SolarHalfYear.fromIndex(2023, 0).next(-4).description)
        XCTAssertEqual("2021年下半年", try SolarHalfYear.fromIndex(2023, 0).next(-3).description)
    }
}
