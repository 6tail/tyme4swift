import Tyme4Swift
import XCTest

/// 儒略日测试
final class JulianDayTests: XCTestCase {
    func test0() {
        XCTAssertEqual(
            "2023年1月1日",
            try SolarDay.fromYmd(2023, 1, 1).getJulianDay().getSolarDay().description
        )
    }
}
