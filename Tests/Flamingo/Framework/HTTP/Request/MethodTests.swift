import XCTest
@testable import Flamingo

class MethodTests: XCTestCase {

  static var allTests: [(String, (MethodTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
