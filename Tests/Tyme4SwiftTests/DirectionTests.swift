import Tyme4Swift
import XCTest

/// 方位测试
final class DirectionTest: XCTestCase {
    /// 福神方位
    func test1() {
        XCTAssertEqual(
            "东南",
            try SolarDay.fromYmd(2021, 11, 13)
                .getLunarDay()
                .sixtyCycle
                .heavenStem
                .mascotDirection
                .getName()
        )
    }

    /// 福神方位
    func test2() {
        XCTAssertEqual(
            "东南",
            try SolarDay.fromYmd(2024, 1, 1)
                .getLunarDay()
                .sixtyCycle
                .heavenStem
                .mascotDirection
                .getName()
        )
    }

    /// 太岁方位
    func test3() {
        XCTAssertEqual(
            "东",
            try SolarDay.fromYmd(2023, 11, 6)
                .getLunarDay()
                .jupiterDirection
                .getName()
        )
    }
}
