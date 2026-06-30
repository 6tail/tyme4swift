import Tyme4Swift
import XCTest

/// 回历年测试
final class HijriYearTest: XCTestCase {
    func test0() {
        XCTAssertFalse(try HijriYear.fromYear(1).isLeap)
        XCTAssertTrue(try HijriYear.fromYear(2).isLeap)
        XCTAssertFalse(try HijriYear.fromYear(0).isLeap)
        XCTAssertTrue(try HijriYear.fromYear(-1).isLeap)
    }
}
