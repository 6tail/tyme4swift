import Tyme4Swift
import XCTest

/// 六十甲子测试
final class SixtyCycleTests: XCTestCase {
    func test0() {
        XCTAssertEqual("丁丑", SixtyCycle.fromIndex(13).getName())
    }

    func test1() {
        XCTAssertEqual(13, try SixtyCycle.fromName("丁丑").index)
    }

    /// 五行
    func test2() {
        XCTAssertEqual("石榴木", try SixtyCycle.fromName("辛酉").sound.getName())
        XCTAssertEqual("剑锋金", try SixtyCycle.fromName("癸酉").sound.getName())
        XCTAssertEqual("平地木", try SixtyCycle.fromName("己亥").sound.getName())
    }

    /// 旬
    func test3() {
        XCTAssertEqual("甲子", try SixtyCycle.fromName("甲子").ten.getName())
        XCTAssertEqual("甲寅", try SixtyCycle.fromName("乙卯").ten.getName())
        XCTAssertEqual("甲申", try SixtyCycle.fromName("癸巳").ten.getName())
    }

    /// 旬空
    func test4() {
        XCTAssertEqual(
            "戌亥",
            try SixtyCycle.fromName("甲子").extraEarthBranches.map { $0.description }.joined()
        )
        XCTAssertEqual(
            "子丑",
            try SixtyCycle.fromName("乙卯").extraEarthBranches.map { $0.description }.joined()
        )
        XCTAssertEqual(
            "午未",
            try SixtyCycle.fromName("癸巳").extraEarthBranches.map { $0.description }.joined()
        )
    }

    /// 地势(长生十二神)
    func test5() {
        XCTAssertEqual("长生", try HeavenStem.fromName("丙").getTerrain(EarthBranch.fromName("寅")).getName())
        XCTAssertEqual("沐浴", try HeavenStem.fromName("辛").getTerrain(EarthBranch.fromName("亥")).getName())
    }
}
