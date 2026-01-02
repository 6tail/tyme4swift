import Tyme4Swift
import XCTest

/// 六曜测试
final class SixStarTests: XCTestCase {
    func test0() {
        XCTAssertEqual("佛灭", try SolarDay.fromYmd(2020, 4, 23).getLunarDay().sixStar.getName())
    }

    func test1() {
        XCTAssertEqual("友引", try SolarDay.fromYmd(2021, 1, 15).getLunarDay().sixStar.getName())
    }

    func test2() {
        XCTAssertEqual("先胜", try SolarDay.fromYmd(2017, 1, 5).getLunarDay().sixStar.getName())
    }

    func test3() {
        XCTAssertEqual("友引", try SolarDay.fromYmd(2020, 4, 10).getLunarDay().sixStar.getName())
    }

    func test4() {
        XCTAssertEqual("大安", try SolarDay.fromYmd(2020, 6, 11).getLunarDay().sixStar.getName())
    }

    func test5() {
        XCTAssertEqual("先胜", try SolarDay.fromYmd(2020, 6, 1).getLunarDay().sixStar.getName())
    }

    func test6() {
        XCTAssertEqual("先负", try SolarDay.fromYmd(2020, 12, 8).getLunarDay().sixStar.getName())
    }

    func test8() {
        XCTAssertEqual("赤口", try SolarDay.fromYmd(2020, 12, 11).getLunarDay().sixStar.getName())
    }
}
