import Tyme4Swift
import XCTest

/// 天干测试
final class HeavenlyStemTests: XCTestCase {
    func test0() {
        XCTAssertEqual("甲", HeavenStem.fromIndex(0).getName())
    }

    func test1() {
        XCTAssertEqual(0, try HeavenStem.fromName("甲").index)
    }

    /// 天干的五行生克
    func test2() {
        XCTAssertEqual(
            try HeavenStem.fromName("丙").element,
            try HeavenStem.fromName("甲").element.getReinforce()
        )
    }

    /// 十神
    func test3() {
        XCTAssertEqual("比肩", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("甲")).getName())
        XCTAssertEqual("劫财", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("乙")).getName())
        XCTAssertEqual("食神", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("丙")).getName())
        XCTAssertEqual("伤官", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("丁")).getName())
        XCTAssertEqual("偏财", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("戊")).getName())
        XCTAssertEqual("正财", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("己")).getName())
        XCTAssertEqual("七杀", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("庚")).getName())
        XCTAssertEqual("正官", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("辛")).getName())
        XCTAssertEqual("偏印", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("壬")).getName())
        XCTAssertEqual("正印", try HeavenStem.fromName("甲").getTenStar(HeavenStem.fromName("癸")).getName())
    }
}
