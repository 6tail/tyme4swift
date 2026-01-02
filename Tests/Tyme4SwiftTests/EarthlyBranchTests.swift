import Tyme4Swift
import XCTest

/// 地支测试
final class EarthlyBranchTests: XCTestCase {
    func test0() {
        XCTAssertEqual("子", EarthBranch.fromIndex(0).getName())
    }

    func test1() {
        XCTAssertEqual(0, try EarthBranch.fromName("子").index)
    }
}
