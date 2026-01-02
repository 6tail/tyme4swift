import Tyme4Swift
import XCTest

/// 藏历日测试
final class RabByungDayTests: XCTestCase {
    func test0() {
        XCTAssertEqual(
            "第十六饶迥铁虎年十二月初一",
            try SolarDay.fromYmd(1951, 1, 8).getRabByungDay().description
        )
        XCTAssertEqual(
            "1951年1月8日",
            try RabByungDay.fromElementZodiac(15, RabByungElement.fromName("铁"), Zodiac.fromName("虎"), 12, 1).getSolarDay().description
        )
    }

    func test1() {
        XCTAssertEqual(
            "第十八饶迥铁马年十二月三十",
            try SolarDay.fromYmd(2051, 2, 11).getRabByungDay().description
        )
        XCTAssertEqual(
            "2051年2月11日",
            try RabByungDay.fromElementZodiac(17, RabByungElement.fromName("铁"), Zodiac.fromName("马"), 12, 30).getSolarDay().description
        )
    }

    func test2() {
        XCTAssertEqual(
            "第十七饶迥木蛇年二月廿五",
            try SolarDay.fromYmd(2025, 4, 23).getRabByungDay().description
        )
        XCTAssertEqual(
            "2025年4月23日",
            try RabByungDay.fromElementZodiac(16, RabByungElement.fromName("木"), Zodiac.fromName("蛇"), 2, 25).getSolarDay().description
        )
    }

    func test3() {
        XCTAssertEqual(
            "第十六饶迥铁兔年正月初二",
            try SolarDay.fromYmd(1951, 2, 8).getRabByungDay().description
        )
        XCTAssertEqual(
            "1951年2月8日",
            try RabByungDay.fromElementZodiac(15, RabByungElement.fromName("铁"), Zodiac.fromName("兔"), 1, 2).getSolarDay().description
        )
    }

    func test4() {
        XCTAssertEqual(
            "第十六饶迥铁虎年十二月闰十六",
            try SolarDay.fromYmd(1951, 1, 24).getRabByungDay().description
        )
        XCTAssertEqual(
            "1951年1月24日",
            try RabByungDay.fromElementZodiac(15, RabByungElement.fromName("铁"), Zodiac.fromName("虎"), 12, -16).getSolarDay().description
        )
    }

    func test5() {
        XCTAssertEqual(
            "第十六饶迥铁牛年五月十一",
            try SolarDay.fromYmd(1961, 6, 24).getRabByungDay().description
        )
        XCTAssertEqual(
            "1961年6月24日",
            try RabByungDay.fromElementZodiac(15, RabByungElement.fromName("铁"), Zodiac.fromName("牛"), 5, 11).getSolarDay().description
        )
    }

    func test6() {
        XCTAssertEqual(
            "第十六饶迥铁兔年十二月廿八",
            try SolarDay.fromYmd(1952, 2, 23).getRabByungDay().description
        )
        XCTAssertEqual(
            "1952年2月23日",
            try RabByungDay.fromElementZodiac(15, RabByungElement.fromName("铁"), Zodiac.fromName("兔"), 12, 28).getSolarDay().description
        )
    }

    func test7() {
        XCTAssertEqual(
            "第十七饶迥木蛇年二月廿九",
            try SolarDay.fromYmd(2025, 4, 26).getRabByungDay().description
        )
    }

    func test8() {
        XCTAssertEqual(
            "第十七饶迥木蛇年二月廿七",
            try SolarDay.fromYmd(2025, 4, 25).getRabByungDay().description
        )
    }
}
