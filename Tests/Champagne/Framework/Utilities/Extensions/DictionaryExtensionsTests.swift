import XCTest
@testable import Champagne

class DictionaryExtensionsTests: XCTestCase {

  static var allTests: [(String, (DictionaryExtensionsTests) -> () throws -> Void)] {
    return [
      ("testMapValues", testMapValues)
    ]
  }

  // MARK: - Tests

  func testMapValues() {
    let dictionary = ["foo": "bar", "bird": "Champagne"]
    let result = dictionary.mapValues {
      "(\($0))"
    }

    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result["foo"], "(bar)")
    XCTAssertEqual(result["bird"], "(Champagne)")
  }
}
