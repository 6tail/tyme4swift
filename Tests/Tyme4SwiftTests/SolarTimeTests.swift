import Tyme4Swift
import XCTest

/// 公历时刻测试
final class SolarTimeTests: XCTestCase {
    func test0() throws {
        let time = try SolarTime.fromYmdHms(2023, 1, 1, 13, 5, 20)
        XCTAssertEqual("13:05:20", time.getName())
        XCTAssertEqual("13:04:59", try time.next(-21).getName())
    }

    func test1() throws {
        let time = try SolarTime.fromYmdHms(2023, 1, 1, 13, 5, 20)
        XCTAssertEqual("13:05:20", time.getName())
        XCTAssertEqual("14:06:01", try time.next(3641).getName())
    }
}
