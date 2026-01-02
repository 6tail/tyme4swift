import Tyme4Swift
import XCTest

/// 神煞测试
final class GodTests: XCTestCase {
    func test0() {
        let lunar = try! SolarDay.fromYmd(2004, 2, 16).getLunarDay()
        let gods = lunar.gods
        let ji = gods.compactMap { god in
            if god.luck.getName() == "吉" {
                return god.getName()
            }
            return nil
        }

        let xiong = gods.compactMap { god in
            if god.luck.getName() == "凶" {
                return god.getName()
            }
            return nil
        }

        XCTAssertEqual(["天恩", "续世", "明堂"], ji)
        XCTAssertEqual(["月煞", "月虚", "血支", "天贼", "五虚", "土符", "归忌", "血忌"], xiong)
    }
}
