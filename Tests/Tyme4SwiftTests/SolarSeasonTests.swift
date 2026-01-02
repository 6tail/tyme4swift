import Tyme4Swift
import XCTest

/// 公历季度测试
final class SolarSeasonTests: XCTestCase {
    func test0() throws {
        let season = try SolarSeason.fromIndex(2023, 0)
        XCTAssertEqual("2023年一季度", season.description)
        XCTAssertEqual("2021年四季度", try season.next(-5).description)
    }
}
