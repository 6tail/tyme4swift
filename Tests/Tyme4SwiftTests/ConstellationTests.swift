import Tyme4Swift
import XCTest

final class ConstellationTests: XCTestCase {
    func test0() {
        XCTAssertEqual("白羊", try SolarDay.fromYmd(2020, 3, 21).constellation.getName())
        XCTAssertEqual("白羊", try SolarDay.fromYmd(2020, 4, 19).constellation.getName())
    }

    func test1() {
        XCTAssertEqual("金牛", try SolarDay.fromYmd(2020, 4, 20).constellation.getName())
        XCTAssertEqual("金牛", try SolarDay.fromYmd(2020, 5, 20).constellation.getName())
    }

    func test2() {
        XCTAssertEqual("双子", try SolarDay.fromYmd(2020, 5, 21).constellation.getName())
        XCTAssertEqual("双子", try SolarDay.fromYmd(2020, 6, 21).constellation.getName())
    }

    func test3() {
        XCTAssertEqual("巨蟹", try SolarDay.fromYmd(2020, 6, 22).constellation.getName())
        XCTAssertEqual("巨蟹", try SolarDay.fromYmd(2020, 7, 22).constellation.getName())
    }
}
