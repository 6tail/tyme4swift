import Tyme4Swift
import XCTest

/// 时辰测试
final class LunarHourTests: XCTestCase {
    func test1() throws {
        let h = try LunarHour.fromYmdHms(2020, -4, 5, 23, 0, 0)
        XCTAssertEqual("子时", h.getName())
        XCTAssertEqual("农历庚子年闰四月初五戊子时", h.description)
    }

    func test2() throws {
        let h = try LunarHour.fromYmdHms(2020, -4, 5, 0, 59, 0)
        XCTAssertEqual("子时", h.getName())
        XCTAssertEqual("农历庚子年闰四月初五丙子时", h.description)
    }

    func test3() throws {
        let h = try LunarHour.fromYmdHms(2020, -4, 5, 1, 0, 0)
        XCTAssertEqual("丑时", h.getName())
        XCTAssertEqual("农历庚子年闰四月初五丁丑时", h.description)
    }

    func test4() throws {
        let h = try LunarHour.fromYmdHms(2020, -4, 5, 21, 30, 0)
        XCTAssertEqual("亥时", h.getName())
        XCTAssertEqual("农历庚子年闰四月初五丁亥时", h.description)
    }

    func test5() throws {
        let h = try LunarHour.fromYmdHms(2020, -4, 2, 23, 30, 0)
        XCTAssertEqual("子时", h.getName())
        XCTAssertEqual("农历庚子年闰四月初二壬子时", h.description)
    }

    func test6() throws {
        let h = try LunarHour.fromYmdHms(2020, 4, 28, 23, 30, 0)
        XCTAssertEqual("子时", h.getName())
        XCTAssertEqual("农历庚子年四月廿八甲子时", h.description)
    }

    func test7() throws {
        let h = try LunarHour.fromYmdHms(2020, 4, 29, 0, 0, 0)
        XCTAssertEqual("子时", h.getName())
        XCTAssertEqual("农历庚子年四月廿九甲子时", h.description)
    }

    func test8() throws {
        let h = try LunarHour.fromYmdHms(2023, 11, 14, 23, 0, 0)
        XCTAssertEqual("甲子", h.sixtyCycle.getName())

        XCTAssertEqual("己未", h.getSixtyCycleHour().day.getName())
        XCTAssertEqual("戊午", h.lunarDay.sixtyCycle.getName())
        XCTAssertEqual("农历癸卯年十一月十四", h.lunarDay.description)

        XCTAssertEqual("甲子", h.getSixtyCycleHour().month.getName())
        XCTAssertEqual("农历癸卯年十一月", h.lunarDay.lunarMonth.description)
        XCTAssertEqual("甲子", h.lunarDay.lunarMonth.sixtyCycle.getName())

        XCTAssertEqual("癸卯", h.getSixtyCycleHour().year.getName())
        XCTAssertEqual("农历癸卯年", h.lunarDay.lunarMonth.lunarYear.description)
        XCTAssertEqual("癸卯", h.lunarDay.lunarMonth.lunarYear.sixtyCycle.getName())
    }

    func test9() throws {
        let h = try LunarHour.fromYmdHms(2023, 11, 14, 6, 0, 0)
        XCTAssertEqual("乙卯", h.sixtyCycle.getName())

        XCTAssertEqual("戊午", h.getSixtyCycleHour().day.getName())
        XCTAssertEqual("戊午", h.lunarDay.sixtyCycle.getName())
        XCTAssertEqual("农历癸卯年十一月十四", h.lunarDay.description)

        XCTAssertEqual("甲子", h.getSixtyCycleHour().month.getName())
        XCTAssertEqual("农历癸卯年十一月", h.lunarDay.lunarMonth.description)
        XCTAssertEqual("甲子", h.lunarDay.lunarMonth.sixtyCycle.getName())

        XCTAssertEqual("癸卯", h.getSixtyCycleHour().year.getName())
        XCTAssertEqual("农历癸卯年", h.lunarDay.lunarMonth.lunarYear.description)
        XCTAssertEqual("癸卯", h.lunarDay.lunarMonth.lunarYear.sixtyCycle.getName())
    }

    func test28() throws {
        let h = try LunarHour.fromYmdHms(2024, 9, 7, 10, 0, 0)
        XCTAssertEqual("留连", h.minorRen.getName())
    }
}
