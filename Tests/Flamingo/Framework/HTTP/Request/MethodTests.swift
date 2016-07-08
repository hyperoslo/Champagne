import XCTest
@testable import Flamingo

class MethodTests: XCTestCase {

  static var allTests: [(String, (MethodTests) -> () throws -> Void)] {
    return [
      ("testInitWithRawValue", testInitWithRawValue)
    ]
  }

  // MARK: - Tests

  func testInitWithRawValue() {
    XCTAssertEqual(Method(rawValue: "patch"), Method.patch)
    XCTAssertEqual(Method(rawValue: "put"), Method.put)
    XCTAssertEqual(Method(rawValue: "delete"), Method.delete)
    XCTAssertEqual(Method(rawValue: "head"), Method.head)
    XCTAssertEqual(Method(rawValue: "options"), Method.options)
    XCTAssertNil(Method(rawValue: "test"))
  }
}
