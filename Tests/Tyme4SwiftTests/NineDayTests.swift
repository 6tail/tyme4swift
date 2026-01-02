import Tyme4Swift
import XCTest

/// 数九测试
final class NineDayTests: XCTestCase {
    func test0() throws {
        let d = try SolarDay.fromYmd(2020, 12, 21).nineDay!
        XCTAssertEqual("一九", d.getName())
        XCTAssertEqual("一九", d.nine.description)
        XCTAssertEqual("一九第1天", d.description)
    }

    func test1() throws {
        let d = try SolarDay.fromYmd(2020, 12, 22).nineDay!
        XCTAssertEqual("一九", d.getName())
        XCTAssertEqual("一九", d.nine.description)
        XCTAssertEqual("一九第2天", d.description)
    }

    func test2() throws {
        let d = try SolarDay.fromYmd(2020, 1, 7).nineDay!
        XCTAssertEqual("二九", d.getName())
        XCTAssertEqual("二九", d.nine.description)
        XCTAssertEqual("二九第8天", d.description)
    }

    func test3() throws {
        let d = try SolarDay.fromYmd(2021, 1, 6).nineDay!
        XCTAssertEqual("二九", d.getName())
        XCTAssertEqual("二九", d.nine.description)
        XCTAssertEqual("二九第8天", d.description)
    }

    func test4() throws {
        let d = try SolarDay.fromYmd(2021, 1, 8).nineDay!
        XCTAssertEqual("三九", d.getName())
        XCTAssertEqual("三九", d.nine.description)
        XCTAssertEqual("三九第1天", d.description)
    }

    func test5() throws {
        let d = try SolarDay.fromYmd(2021, 3, 5).nineDay!
        XCTAssertEqual("九九", d.getName())
        XCTAssertEqual("九九", d.nine.description)
        XCTAssertEqual("九九第3天", d.description)
    }

    func test6() {
        XCTAssertNil(try SolarDay.fromYmd(2021, 7, 5).nineDay)
    }
}
