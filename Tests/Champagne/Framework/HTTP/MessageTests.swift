import XCTest
@testable import Champagne

class MessageTests: XCTestCase {

  static var allTests: [(String, (MessageTests) -> () throws -> Void)] {
    return [
      ("testBodyString", testBodyString)
    ]
  }

  var message: Request!

  override func setUp() {
    super.setUp()

    message = Request(
      method: Method.get,
      uri: URI(path: "/"),
      body: Data("")
    )
  }

  // MARK: - Tests

  func testBodyString() {
    message.body = Body.buffer("test")
    XCTAssertEqual(message.bodyString, "test")
  }
}
