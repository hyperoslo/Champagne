import XCTest
@testable import Flamingo

class ContainerTests: XCTestCase {

  static var allTests: [(String, (ContainerTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
