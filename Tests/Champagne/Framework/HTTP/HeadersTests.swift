import XCTest
@testable import Flamingo

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
      "Server": "Champagne \(Application.version)",
      "Content-Type": "application/json"
    ]
  }

  // MARK: - Tests

  func testDescription() {
    let result = "Server: Champagne \(Application.version)\nContent-Type: application/json\n"
    XCTAssertEqual(headers.description, result)
  }
}
