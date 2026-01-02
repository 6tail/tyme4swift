import Tyme4Swift
import XCTest

/// 节气测试
final class SolarTermTests: XCTestCase {
    func test0() throws {
        // 冬至在去年，2022-12-22 05:48:11
        let dongZhi = try SolarTerm.fromName(2023, "冬至")
        XCTAssertEqual("冬至", dongZhi.getName())
        XCTAssertEqual(0, dongZhi.index)
        // 公历日
        XCTAssertEqual("2022年12月22日", dongZhi.julianDay.getSolarDay().description)
        XCTAssertEqual("2022年12月22日", dongZhi.getSolarDay().description)

        // 冬至顺推23次，就是大雪 2023-12-07 17:32:55
        let daXue = dongZhi.next(23)
        XCTAssertEqual("大雪", daXue.getName())
        XCTAssertEqual(23, daXue.index)
        XCTAssertEqual("2023年12月7日", daXue.julianDay.getSolarDay().description)
        XCTAssertEqual("2023年12月7日", daXue.getSolarDay().description)

        // 冬至逆推2次，就是上一年的小雪 2022-11-22 16:20:28
        let xiaoXue = dongZhi.next(-2)
        XCTAssertEqual("小雪", xiaoXue.getName())
        XCTAssertEqual(22, xiaoXue.index)
        XCTAssertEqual("2022年11月22日", xiaoXue.julianDay.getSolarDay().description)
        XCTAssertEqual("2022年11月22日", xiaoXue.getSolarDay().description)

        // 冬至顺推24次，就是下一个冬至 2023-12-22 11:27:20
        let dongZhi2 = dongZhi.next(24)
        XCTAssertEqual("冬至", dongZhi2.getName())
        XCTAssertEqual(0, dongZhi2.index)
        XCTAssertEqual("2023年12月22日", dongZhi2.julianDay.getSolarDay().description)
        XCTAssertEqual("2023年12月22日", dongZhi2.getSolarDay().description)
    }

    func test1() throws {
        // 公历2023年的雨水，2023-02-19 06:34:16
        let jq = try SolarTerm.fromName(2023, "雨水")
        XCTAssertEqual("雨水", jq.getName())
        XCTAssertEqual(4, jq.index)
    }

    func test2() throws {
        // 公历2023年的大雪，2023-12-07 17:32:55
        let jq = try SolarTerm.fromName(2023, "大雪")
        XCTAssertEqual("大雪", jq.getName())
        // 索引
        XCTAssertEqual(23, jq.index)
        // 公历
        XCTAssertEqual("2023年12月7日", jq.julianDay.getSolarDay().description)
        XCTAssertEqual("2023年12月7日", jq.getSolarDay().description)
        // 农历
        XCTAssertEqual("农历癸卯年十月廿五", jq.julianDay.getSolarDay().getLunarDay().description)
        // 推移
        XCTAssertEqual("雨水", jq.next(5).getName())
    }

    func test3() {
        XCTAssertEqual("寒露", try SolarDay.fromYmd(2023, 10, 10).term.getName())
    }

    func test4() {
        // 大雪当天
        XCTAssertEqual("大雪第1天", try SolarDay.fromYmd(2023, 12, 7).termDay.description)
        // 天数索引
        XCTAssertEqual(0, try SolarDay.fromYmd(2023, 12, 7).termDay.dayIndex)

        XCTAssertEqual("大雪第2天", try SolarDay.fromYmd(2023, 12, 8).termDay.description)
        XCTAssertEqual("大雪第15天", try SolarDay.fromYmd(2023, 12, 21).termDay.description)

        XCTAssertEqual("冬至第1天", try SolarDay.fromYmd(2023, 12, 22).termDay.description)
    }

    func test6() {
        XCTAssertEqual("1034年10月1日", try SolarTerm.fromName(1034, "寒露").getSolarDay().description)
        XCTAssertEqual("1034年10月3日", try SolarTerm.fromName(1034, "寒露").julianDay.getSolarDay().description)
        XCTAssertEqual("1034年10月3日 06:02:28", try SolarTerm.fromName(1034, "寒露").julianDay.getSolarTime().description)
    }
}
