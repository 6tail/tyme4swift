import Tyme4Swift
import XCTest

/// 三柱测试
final class ThreePillarsTest: XCTestCase {
    func test0() {
        XCTAssertEqual("甲戌 甲戌 甲戌", try SolarDay.fromYmd(1034, 10, 2).getSixtyCycleDay().threePillars.getName())
    }
}
