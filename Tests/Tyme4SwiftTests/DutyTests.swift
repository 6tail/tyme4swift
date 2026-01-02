import Tyme4Swift
import XCTest

/// 建除十二值神测试
final class DutyTests: XCTestCase {
    func test0() {
        XCTAssertEqual("闭", try SolarDay.fromYmd(2023, 10, 30).getLunarDay().duty.getName())
    }

    func test1() {
        XCTAssertEqual("建", try SolarDay.fromYmd(2023, 10, 19).getLunarDay().duty.getName())
    }

    func test2() {
        XCTAssertEqual("除", try SolarDay.fromYmd(2023, 10, 7).getLunarDay().duty.getName())
    }

    func test3() {
        XCTAssertEqual("除", try SolarDay.fromYmd(2023, 10, 8).getLunarDay().duty.getName())
    }
}
