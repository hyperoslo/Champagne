import XCTest
@testable import Flamingo

class BubbleSchemeTests: XCTestCase {

  static var allTests: [(String, (BubbleSchemeTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
