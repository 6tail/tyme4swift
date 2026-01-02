import Tyme4Swift
import XCTest

/// 藏历月测试
final class RabByungMonthTests: XCTestCase {
    func test0() {
        XCTAssertEqual("第十六饶迥铁虎年十二月", try RabByungMonth.fromYm(1950, 12).description)
    }
}
