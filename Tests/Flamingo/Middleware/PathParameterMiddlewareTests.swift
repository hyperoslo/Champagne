import XCTest
@testable import Flamingo

class PathParametersMiddlewareTests: XCTestCase {

  static var allTests: [(String, (PathParametersMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(2, 2)
  }
}
