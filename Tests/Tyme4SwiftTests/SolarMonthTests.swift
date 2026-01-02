import Tyme4Swift
import XCTest

/// 公历月测试
final class SolarMonthTests: XCTestCase {
    func test0() throws {
        let m = try SolarMonth.fromYm(2019, 5)
        XCTAssertEqual("5月", m.getName())
        XCTAssertEqual("2019年5月", m.description)
    }

    func test1() throws {
        let m = try SolarMonth.fromYm(2023, 1)
        XCTAssertEqual(5, m.getWeekCount(0))
        XCTAssertEqual(6, m.getWeekCount(1))
        XCTAssertEqual(6, m.getWeekCount(2))
        XCTAssertEqual(5, m.getWeekCount(3))
        XCTAssertEqual(5, m.getWeekCount(4))
        XCTAssertEqual(5, m.getWeekCount(5))
        XCTAssertEqual(5, m.getWeekCount(6))
    }

    func test2() throws {
        let m = try SolarMonth.fromYm(2023, 2)
        XCTAssertEqual(5, m.getWeekCount(0))
        XCTAssertEqual(5, m.getWeekCount(1))
        XCTAssertEqual(5, m.getWeekCount(2))
        XCTAssertEqual(4, m.getWeekCount(3))
        XCTAssertEqual(5, m.getWeekCount(4))
        XCTAssertEqual(5, m.getWeekCount(5))
        XCTAssertEqual(5, m.getWeekCount(6))
    }

    func test3() throws {
        let m = try SolarMonth.fromYm(2023, 10).next(1)
        XCTAssertEqual("11月", m.getName())
        XCTAssertEqual("2023年11月", m.description)
    }

    func test4() throws {
        let m = try SolarMonth.fromYm(2023, 10)
        XCTAssertEqual("2023年12月", try m.next(2).description)
        XCTAssertEqual("2024年1月", try m.next(3).description)
        XCTAssertEqual("2023年5月", try m.next(-5).description)
        XCTAssertEqual("2023年1月", try m.next(-9).description)
        XCTAssertEqual("2022年12月", try m.next(-10).description)
        XCTAssertEqual("2025年10月", try m.next(24).description)
        XCTAssertEqual("2021年10月", try m.next(-24).description)
    }
}
