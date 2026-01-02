import XCTest
import Tyme4Swift

final class AnimalTests: XCTestCase {
    func test1() {
        XCTAssertEqual(Animal.fromIndex(0).getName(), "蛟")
    }
}
