import XCTest
@testable import Flamingo

class DictionaryExtensionsTests: XCTestCase {

  static var allTests: [(String, (DictionaryExtensionsTests) -> () throws -> Void)] {
    return [
      ("testMapValues", testMapValues)
    ]
  }

  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests

  func testMapValues() {
    XCTAssertEqual(2, 2)
  }
}
