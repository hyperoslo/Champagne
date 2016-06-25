import XCTest
@testable import Flamingo

class DictionaryExtensionsTests: XCTestCase {

  static var allTests: [(String, (DictionaryExtensionsTests) -> () throws -> Void)] {
    return [
      ("testMapValues", testMapValues)
    ]
  }

  // MARK: - Tests

  func testMapValues() {
    let dictionary = ["foo": "bar", "bird": "flamingo"]
    let result = dictionary.mapValues {
      "(\($0))"
    }

    XCTAssertEqual(result.count, 2)
    XCTAssertEqual(result["foo"], "(bar)")
    XCTAssertEqual(result["bird"], "(flamingo)")
  }
}
