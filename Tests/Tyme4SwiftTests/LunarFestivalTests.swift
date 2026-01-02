import Tyme4Swift
import XCTest

/// 农历传统节日测试
final class LunarFestivalTests: XCTestCase {
    func test0() {
        for i in 0 ..< LunarFestival.NAMES.count {
            let f = LunarFestival.fromIndex(2023, i)
            XCTAssertNotNil(f)
            XCTAssertEqual(LunarFestival.NAMES[i], f?.getName())
        }
    }

    func test1() {
        let f = LunarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        for i in 0 ..< LunarFestival.NAMES.count {
            XCTAssertEqual(LunarFestival.NAMES[i], f?.next(i)?.getName())
        }
    }

    func test2() {
        let f = LunarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        XCTAssertEqual("农历癸卯年正月初一 春节", f?.description)
        XCTAssertEqual("农历甲辰年正月初一 春节", f?.next(13)?.description)
        XCTAssertEqual("农历壬寅年十二月三十 除夕", f?.next(-1)?.description)
        XCTAssertEqual("农历壬寅年十二月初八 腊八节", f?.next(-2)?.description)
        XCTAssertEqual("农历壬寅年十一月廿九 冬至节", f?.next(-3)?.description)
    }

    func test3() {
        let f = LunarFestival.fromIndex(2023, 0)
        XCTAssertNotNil(f)
        XCTAssertEqual("农历壬寅年三月初五 清明节", f?.next(-9)?.description)
    }

    func test4() throws {
        let f = try LunarDay.fromYmd(2010, 1, 15).festival
        XCTAssertNotNil(f)
        XCTAssertEqual("农历庚寅年正月十五 元宵节", f?.description)
    }

    func test5() throws {
        let f = try LunarDay.fromYmd(2021, 12, 29).festival
        XCTAssertNotNil(f)
        XCTAssertEqual("农历辛丑年十二月廿九 除夕", f?.description)
    }
}
