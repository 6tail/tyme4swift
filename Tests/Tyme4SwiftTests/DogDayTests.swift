import Tyme4Swift
import XCTest

/// 方位测试
final class DogDayTests: XCTestCase {
    func test0() throws {
        let d = try SolarDay.fromYmd(2011, 7, 14).dogDay!
        XCTAssertEqual("初伏", d.getName())
        XCTAssertEqual("初伏", d.dog.description)
        XCTAssertEqual("初伏第1天", d.description)
    }

    func test1() throws {
        let d = try SolarDay.fromYmd(2011, 7, 23).dogDay!
        XCTAssertEqual("初伏", d.getName())
        XCTAssertEqual("初伏", d.dog.description)
        XCTAssertEqual("初伏第10天", d.description)
    }

    func test2() throws {
        let d = try SolarDay.fromYmd(2011, 7, 24).dogDay!
        XCTAssertEqual("中伏", d.getName())
        XCTAssertEqual("中伏", d.dog.description)
        XCTAssertEqual("中伏第1天", d.description)
    }

    func test3() throws {
        let d = try SolarDay.fromYmd(2011, 8, 12).dogDay!
        XCTAssertEqual("中伏", d.getName())
        XCTAssertEqual("中伏", d.dog.description)
        XCTAssertEqual("中伏第20天", d.description)
    }

    func test4() throws {
        let d = try SolarDay.fromYmd(2011, 8, 13).dogDay!
        XCTAssertEqual("末伏", d.getName())
        XCTAssertEqual("末伏", d.dog.description)
        XCTAssertEqual("末伏第1天", d.description)
    }

    func test5() throws {
        let d = try SolarDay.fromYmd(2011, 8, 22).dogDay!
        XCTAssertEqual("末伏", d.getName())
        XCTAssertEqual("末伏", d.dog.description)
        XCTAssertEqual("末伏第10天", d.description)
    }

    func test6() throws {
        XCTAssertNil(try SolarDay.fromYmd(2011, 7, 13).dogDay)
    }

    func test7() throws {
        XCTAssertNil(try SolarDay.fromYmd(2011, 8, 23).dogDay)
    }

    func test8() throws {
        let d = try SolarDay.fromYmd(2012, 7, 18).dogDay!
        XCTAssertEqual("初伏", d.getName())
        XCTAssertEqual("初伏", d.dog.description)
        XCTAssertEqual("初伏第1天", d.description)
    }

    func test9() throws {
        let d = try SolarDay.fromYmd(2012, 8, 5).dogDay!
        XCTAssertEqual("中伏", d.getName())
        XCTAssertEqual("中伏", d.dog.description)
        XCTAssertEqual("中伏第9天", d.description)
    }

    func test10() throws {
        let d = try SolarDay.fromYmd(2012, 8, 8).dogDay!
        XCTAssertEqual("末伏", d.getName())
        XCTAssertEqual("末伏", d.dog.description)
        XCTAssertEqual("末伏第2天", d.description)
    }
}
