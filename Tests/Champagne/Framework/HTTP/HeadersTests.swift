import XCTest
@testable import Champagne

class HeadersTests: XCTestCase {

  static var allTests: [(String, (HeadersTests) -> () throws -> Void)] {
    return [
      ("testDescription", testDescription)
    ]
  }

  var headers: Headers!

  override func setUp() {
    super.setUp()

    headers = [
      "Content-Type": "application/json"
    ]
  }

  // MARK: - Tests

  func testDescription() {
    let result = "Content-Type: application/json\n"
    XCTAssertEqual(headers.description, result)
  }
}
