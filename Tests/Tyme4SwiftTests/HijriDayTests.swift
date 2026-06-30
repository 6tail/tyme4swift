import Tyme4Swift
import XCTest

/// 回历日测试
final class HijriDayTest: XCTestCase {
    func test0() {
        XCTAssertEqual("1年穆哈兰姆月1日", try SolarDay.fromYmd(622, 7, 16).getHijriDay().description)
    }
    
    func test1() {
        XCTAssertEqual("1447年都尔喀尔德月26日", try SolarDay.fromYmd(2026, 5, 13).getHijriDay().description)
        XCTAssertEqual("2026年5月13日", try HijriDay.fromYmd(1447, 11, 26).getSolarDay().description)
    }
    
    func test2() {
        XCTAssertEqual("-538年都尔黑哲月12日", try SolarDay.fromYmd(100, 7, 8).getHijriDay().description)
        XCTAssertEqual("100年7月8日", try HijriDay.fromYmd(-538, 12, 12).getSolarDay().description)
    }
    
    func test3() {
        XCTAssertEqual("0年都尔黑哲月29日", try SolarDay.fromYmd(622, 7, 15).getHijriDay().description)
        XCTAssertEqual("622年7月15日", try HijriDay.fromYmd(0, 12, 29).getSolarDay().description)
    }
    
    func test4() {
        XCTAssertEqual("-640年主马达·敖外鲁月16日", try SolarDay.fromYmd(1, 1, 1).getHijriDay().description)
        XCTAssertEqual("1年1月1日", try HijriDay.fromYmd(-640, 5, 16).getSolarDay().description)
    }
    
    func test5() {
        XCTAssertEqual("9666年赖比尔·阿色尼月2日", try SolarDay.fromYmd(9999, 12, 31).getHijriDay().description)
        XCTAssertEqual("9999年12月31日", try HijriDay.fromYmd(9666, 4, 2).getSolarDay().description)
    }
}
