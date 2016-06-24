import XCTest
@testable import Flamingo

class RouteTests: XCTestCase {

  static var allTests: [(String, (RouteTests) -> () throws -> Void)] {
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
