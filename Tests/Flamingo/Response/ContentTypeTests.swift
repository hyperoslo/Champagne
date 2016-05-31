import XCTest
@testable import Flamingo

class ContentTypeTests: XCTestCase {

  static var allTests: [(String, (ContentTypeTests) -> () throws -> Void)] {
    return [
      ("testRawValues", testRawValues),
    ]
  }

  func testRawValues() {
    XCTAssertEqual(ContentType.plain.rawValue, "text/plain")
    XCTAssertEqual(ContentType.html.rawValue, "text/html")
    XCTAssertEqual(ContentType.json.rawValue, "application/json")
  }
}
