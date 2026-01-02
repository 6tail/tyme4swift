import Tyme4Swift
import XCTest

/// 藏历年测试
final class RabByungYearTests: XCTestCase {
    func test0() throws {
        let y = try RabByungYear.fromElementZodiac(0, RabByungElement.fromName("火"), Zodiac.fromName("兔"))
        XCTAssertEqual("第一饶迥火兔年", y.getName())
        XCTAssertEqual("1027年", y.getSolarYear().getName())
        XCTAssertEqual("丁卯", y.sixtyCycle.getName())
        XCTAssertEqual(10, y.leapMonth)
    }

    func test1() {
        XCTAssertEqual("第一饶迥火兔年", try RabByungYear.fromYear(1027).getName())
    }

    func test2() {
        XCTAssertEqual("第十七饶迥铁虎年", try RabByungYear.fromYear(2010).getName())
    }

    func test3() {
        XCTAssertEqual(5, try RabByungYear.fromYear(2043).leapMonth)
        XCTAssertEqual(0, try RabByungYear.fromYear(2044).leapMonth)
    }

    func test4() {
        XCTAssertEqual("第十六饶迥铁牛年", try RabByungYear.fromYear(1961).getName())
    }
}
