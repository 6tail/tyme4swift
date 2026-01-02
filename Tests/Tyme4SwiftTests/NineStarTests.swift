import Tyme4Swift
import XCTest

/// 九星测试
final class NineStarTests: XCTestCase {
    func test0() throws {
        let nineStar = try LunarYear.fromYear(1985).nineStar
        XCTAssertEqual("六", nineStar.getName())
        XCTAssertEqual("六白金", nineStar.description)
    }

    func test1() throws {
        let nineStar = try LunarYear.fromYear(2022).nineStar
        XCTAssertEqual("五黄土", nineStar.description)
        XCTAssertEqual("玉衡", nineStar.dipper.description)
    }

    func test2() throws {
        let nineStar = try LunarYear.fromYear(2033).nineStar
        XCTAssertEqual("三碧木", nineStar.description)
        XCTAssertEqual("天玑", nineStar.dipper.description)
    }

    func test3() throws {
        let nineStar = try LunarMonth.fromYm(1985, 2).nineStar
        XCTAssertEqual("四绿木", nineStar.description)
        XCTAssertEqual("天权", nineStar.dipper.description)
    }

    func test4() throws {
        let nineStar = try LunarMonth.fromYm(1985, 2).nineStar
        XCTAssertEqual("四绿木", nineStar.description)
        XCTAssertEqual("天权", nineStar.dipper.description)
    }

    func test5() throws {
        let nineStar = try LunarMonth.fromYm(2022, 1).nineStar
        XCTAssertEqual("二黑土", nineStar.description)
        XCTAssertEqual("天璇", nineStar.dipper.description)
    }

    func test6() throws {
        let nineStar = try LunarMonth.fromYm(2033, 1).nineStar
        XCTAssertEqual("五黄土", nineStar.description)
        XCTAssertEqual("玉衡", nineStar.dipper.description)
    }

    func test7() throws {
        let nineStar = try SolarDay.fromYmd(1985, 2, 19).getLunarDay().nineStar
        XCTAssertEqual("五黄土", nineStar.description)
        XCTAssertEqual("玉衡", nineStar.dipper.description)
    }

    func test8() throws {
        let nineStar = try LunarDay.fromYmd(2022, 1, 1).nineStar
        XCTAssertEqual("四绿木", nineStar.description)
        XCTAssertEqual("天权", nineStar.dipper.description)
    }

    func test9() throws {
        let nineStar = try LunarDay.fromYmd(2033, 1, 1).nineStar
        XCTAssertEqual("一白水", nineStar.description)
        XCTAssertEqual("天枢", nineStar.dipper.description)
    }

    func test10() throws {
        let nineStar = try LunarHour.fromYmdHms(2033, 1, 1, 12, 0, 0).nineStar
        XCTAssertEqual("七赤金", nineStar.description)
        XCTAssertEqual("摇光", nineStar.dipper.description)
    }

    func test11() throws {
        let nineStar = try LunarHour.fromYmdHms(2011, 5, 3, 23, 0, 0).nineStar
        XCTAssertEqual("七赤金", nineStar.description)
        XCTAssertEqual("摇光", nineStar.dipper.description)
    }
}
