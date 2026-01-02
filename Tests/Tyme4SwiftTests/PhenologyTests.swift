import Tyme4Swift
import XCTest

/// 物候测试
final class PhenologyTests: XCTestCase {
    func test0() throws {
        let solarDay = try SolarDay.fromYmd(2020, 4, 23)
        // 七十二候
        let phenology = solarDay.phenologyDay
        // 三候
        let threePhenology = phenology.phenology.threePhenology
        XCTAssertEqual("谷雨", solarDay.term.getName())
        XCTAssertEqual("初候", threePhenology.getName())
        XCTAssertEqual("萍始生", phenology.getName())
        // 该候的第5天
        XCTAssertEqual(4, phenology.dayIndex)
    }

    func test1() throws {
        let solarDay = try SolarDay.fromYmd(2021, 12, 26)
        // 七十二候
        let phenology = solarDay.phenologyDay
        // 三候
        let threePhenology = phenology.phenology.threePhenology
        XCTAssertEqual("冬至", solarDay.term.getName())
        XCTAssertEqual("二候", threePhenology.getName())
        XCTAssertEqual("麋角解", phenology.getName())
        // 该候的第1天
        XCTAssertEqual(0, phenology.dayIndex)
    }

    func test2() throws {
        let p = try Phenology.fromIndex(2026, 1)
        let jd = p.julianDay
        XCTAssertEqual("麋角解", p.getName())
        XCTAssertEqual("2025年12月26日", jd.getSolarDay().description)
        XCTAssertEqual("2025年12月26日 20:49:56", jd.getSolarTime().description)
    }

    func test3() throws {
        let p = try SolarDay.fromYmd(2025, 12, 26).phenology
        let jd = p.julianDay
        XCTAssertEqual("麋角解", p.getName())
        XCTAssertEqual("2025年12月26日", jd.getSolarDay().description)
        XCTAssertEqual("2025年12月26日 20:49:56", jd.getSolarTime().description)
    }

    func test4() {
        XCTAssertEqual("蚯蚓结", try SolarTime.fromYmdHms(2025, 12, 26, 20, 49, 38).phenology.getName())
        XCTAssertEqual("麋角解", try SolarTime.fromYmdHms(2025, 12, 26, 20, 49, 56).phenology.getName())
    }
}
