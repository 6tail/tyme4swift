import Tyme4Swift
import XCTest

/// 胎神测试
final class FetusTests: XCTestCase {
    /// 逐日胎神
    func test1() {
        XCTAssertEqual("碓磨厕 外东南", try! SolarDay.fromYmd(2021, 11, 13).getLunarDay().fetusDay.getName())
    }

    func test2() {
        XCTAssertEqual("占门碓 外东南", try! SolarDay.fromYmd(2021, 11, 12).getLunarDay().fetusDay.getName())
    }

    func test3() {
        XCTAssertEqual("厨灶厕 外西南", try! SolarDay.fromYmd(2011, 11, 12).getLunarDay().fetusDay.getName())
    }
}
