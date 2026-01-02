import Tyme4Swift
import XCTest

/// 五行测试
final class ElementTests: XCTestCase {
    /// 金克木
    func test0() {
        XCTAssertEqual(try! Element.fromName("木"), try! Element.fromName("金").getRestrain())
    }

    /// 火生土
    func test1() {
        XCTAssertEqual(try! Element.fromName("土"), try! Element.fromName("火").getReinforce())
    }

    func test2() {
        XCTAssertEqual("火", try! HeavenStem.fromName("丙").element.getName())
    }

    func test3() {
        // 地支寅的五行为木
        XCTAssertEqual("木", try! EarthBranch.fromName("寅").getElement().getName())

        // 地支寅的五行(木)生火
        XCTAssertEqual(try! Element.fromName("火"), try! EarthBranch.fromName("寅").getElement().getReinforce())
    }

    /// 生我的：火生土
    func test4() {
        XCTAssertEqual(try! Element.fromName("火"), try! Element.fromName("土").getReinforced())
    }

    /// ==
    func test5() {
        XCTAssertTrue(try! Element.fromName("火") == Element.fromIndex(1))
    }

    /// !=
    func test6() {
        XCTAssertTrue(try! Element.fromName("火") != Element.fromName("土"))
    }
}
