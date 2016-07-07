import XCTest
@testable import Flamingo

class ConfigTests: XCTestCase {

  static var allTests: [(String, (ConfigTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
