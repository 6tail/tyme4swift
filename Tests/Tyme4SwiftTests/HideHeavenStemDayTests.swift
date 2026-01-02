import Tyme4Swift
import XCTest

/// 人元司令分野测试
final class HideHeavenStemDayTests: XCTestCase {
    func test0() throws {
        let d = try SolarDay.fromYmd(2024, 12, 4).hideHeavenStemDay
        XCTAssertEqual("本气", d.hideHeavenStem.type.getName())
        XCTAssertEqual("壬", d.hideHeavenStem.getName())
        XCTAssertEqual("壬", d.hideHeavenStem.description)
        XCTAssertEqual("水", d.hideHeavenStem.heavenStem.element.getName())

        XCTAssertEqual("壬水", d.getName())
        XCTAssertEqual(15, d.dayIndex)
        XCTAssertEqual("壬水第16天", d.description)
    }

    func test1() throws {
        let d = try SolarDay.fromYmd(2024, 11, 7).hideHeavenStemDay
        XCTAssertEqual("余气", d.hideHeavenStem.type.getName())
        XCTAssertEqual("戊", d.hideHeavenStem.getName())
        XCTAssertEqual("戊", d.hideHeavenStem.description)
        XCTAssertEqual("土", d.hideHeavenStem.heavenStem.element.getName())

        XCTAssertEqual("戊土", d.getName())
        XCTAssertEqual(0, d.dayIndex)
        XCTAssertEqual("戊土第1天", d.description)
    }
}
