import XCTest
@testable import Flamingo

class BubbleTests: XCTestCase {

  static var allTests: [(String, (BubbleTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
