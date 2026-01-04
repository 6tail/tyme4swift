import Tyme4Swift
import XCTest

/// 宜忌测试
final class TabooTests: XCTestCase {
    func test0() throws {
        let taboos = try SolarDay.fromYmd(2024, 6, 26).getLunarDay().recommends.map { $0.getName() }

        XCTAssertEqual(
            ["嫁娶", "祭祀", "理发", "作灶", "修饰垣墙", "平治道涂", "整手足甲", "沐浴", "冠笄"],
            taboos
        )
    }

    func test1() throws {
        let taboos = try SolarDay.fromYmd(2024, 6, 26).getLunarDay().avoids.map { $0.getName() }

        XCTAssertEqual(
            ["破土", "出行", "栽种"],
            taboos
        )
    }

    func test2() throws {
        let taboos = try SolarTime.fromYmdHms(2024, 4, 22, 0, 0, 0).getLunarHour().recommends.map { $0.getName() }

        XCTAssertEqual(
            ["嫁娶", "交易", "开市", "安床", "祭祀", "求财"],
            taboos
        )
    }

    func test3() throws {
        let taboos = try SolarTime.fromYmdHms(2024, 4, 22, 0, 0, 0).getLunarHour().avoids.map { $0.getName() }

        XCTAssertEqual(
            ["出行", "移徙", "赴任", "词讼", "祈福", "修造", "求嗣"],
            taboos
        )
    }
    
    func test4() throws {
        let taboos = try SolarDay.fromYmd(2026, 1, 6).getLunarDay().recommends.map { $0.getName() }

        XCTAssertEqual(
            ["祭祀", "解除", "修饰垣墙", "平治道涂", "馀事勿取"],
            taboos
        )
    }
    
    func test5() throws {
        let taboos = try SolarDay.fromYmd(2026, 1, 6).getLunarDay().avoids.map { $0.getName() }

        XCTAssertEqual(
            [],
            taboos
        )
    }
}
