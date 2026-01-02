import Tyme4Swift
import XCTest

/// 梅雨天测试
final class PlumRainDayTests: XCTestCase {
    func test0() {
        XCTAssertNil(try SolarDay.fromYmd(2024, 6, 10).plumRainDay)
    }

    func test1() throws {
        let d = try SolarDay.fromYmd(2024, 6, 11).plumRainDay!
        XCTAssertEqual("入梅", d.getName())
        XCTAssertEqual("入梅", d.plumRain.description)
        XCTAssertEqual("入梅第1天", d.description)
    }

    func test2() throws {
        let d = try SolarDay.fromYmd(2024, 7, 6).plumRainDay!
        XCTAssertEqual("出梅", d.getName())
        XCTAssertEqual("出梅", d.plumRain.description)
        XCTAssertEqual("出梅", d.description)
    }

    func test3() throws {
        let d = try SolarDay.fromYmd(2024, 7, 5).plumRainDay!
        XCTAssertEqual("入梅", d.getName())
        XCTAssertEqual("入梅", d.plumRain.description)
        XCTAssertEqual("入梅第25天", d.description)
    }
}
