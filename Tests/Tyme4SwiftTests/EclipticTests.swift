import Tyme4Swift
import XCTest

/// 黄道黑道十二神测试
final class EclipticTest: XCTestCase {
    func test0() {
        let star = try! SolarDay.fromYmd(2023, 10, 30).getLunarDay().twelveStar
        XCTAssertEqual("天德", star.getName())
        XCTAssertEqual("黄道", star.ecliptic.getName())
        XCTAssertEqual("吉", star.ecliptic.luck.getName())
    }

    func test1() {
        let star = try! SolarDay.fromYmd(2023, 10, 19).getLunarDay().twelveStar
        XCTAssertEqual("白虎", star.getName())
        XCTAssertEqual("黑道", star.ecliptic.getName())
        XCTAssertEqual("凶", star.ecliptic.luck.getName())
    }

    func test2() {
        let star = try! SolarDay.fromYmd(2023, 10, 7).getLunarDay().twelveStar
        XCTAssertEqual("天牢", star.getName())
        XCTAssertEqual("黑道", star.ecliptic.getName())
        XCTAssertEqual("凶", star.ecliptic.luck.getName())
    }

    func test3() {
        let star = try! SolarDay.fromYmd(2023, 10, 8).getLunarDay().twelveStar
        XCTAssertEqual("玉堂", star.getName())
        XCTAssertEqual("黄道", star.ecliptic.getName())
        XCTAssertEqual("吉", star.ecliptic.luck.getName())
    }
}
