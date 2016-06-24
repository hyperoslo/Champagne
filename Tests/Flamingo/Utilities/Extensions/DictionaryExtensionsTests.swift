import XCTest
@testable import Flamingo

class DictionaryExtensionsTests: XCTestCase {

  static var allTests: [(String, (DictionaryExtensionsTests) -> () throws -> Void)] {
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
