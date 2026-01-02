import Tyme4Swift
import XCTest

/// 月相测试
final class PhaseTests: XCTestCase {
    func test0() throws {
        let phase = try Phase.fromName(2025, 7, "下弦月")
        XCTAssertEqual("2025年9月14日 18:32:57", phase.solarTime.description)
    }

    func test1() throws {
        let phase = try Phase.fromIndex(2025, 7, 6)
        XCTAssertEqual("2025年9月14日 18:32:57", phase.solarTime.description)
    }

    func test2() throws {
        let phase = try Phase.fromIndex(2025, 7, 8)
        XCTAssertEqual("2025年9月22日 03:54:07", phase.solarTime.description)
    }

    func test3() throws {
        let phase = try SolarDay.fromYmd(2025, 9, 21).phase
        XCTAssertEqual("残月", phase.description)
    }

    func test4() throws {
        let phase = try LunarDay.fromYmd(2025, 7, 30).phase
        XCTAssertEqual("残月", phase.description)
    }

    func test5() throws {
        let phase = try SolarTime.fromYmdHms(2025, 9, 22, 4, 0, 0).phase
        XCTAssertEqual("蛾眉月", phase.description)
    }

    func test6() throws {
        let phase = try SolarTime.fromYmdHms(2025, 9, 22, 3, 0, 0).phase
        XCTAssertEqual("残月", phase.description)
    }

    func test7() throws {
        let d = try SolarDay.fromYmd(2023, 9, 15).phaseDay
        XCTAssertEqual("新月第1天", d.description)
    }

    func test8() throws {
        let d = try SolarDay.fromYmd(2023, 9, 17).phaseDay
        XCTAssertEqual("蛾眉月第2天", d.description)
    }

    func test9() throws {
        let phase = try SolarTime.fromYmdHms(2025, 9, 22, 3, 54, 7).phase
        XCTAssertEqual("新月", phase.description)
    }

    func test10() throws {
        let phase = try SolarTime.fromYmdHms(2025, 9, 22, 3, 54, 6).phase
        XCTAssertEqual("残月", phase.description)
    }

    func test11() throws {
        let phase = try SolarTime.fromYmdHms(2025, 9, 22, 3, 54, 8).phase
        XCTAssertEqual("蛾眉月", phase.description)
    }
}
