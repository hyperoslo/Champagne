import XCTest
@testable import Flamingo

class ResponseTests: XCTestCase {

  static var allTests: [(String, (ResponseTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testBodyString", testBodyString),
    ]
  }

  // MARK: - Tests

  func testInit() {
    let status: Status = .ok
    let contentType: ContentType = .plain
    let response = Response(
      status: status,
      contentType: contentType,
      body: "test"
    )

    XCTAssertEqual(response.status, status)
    XCTAssertEqual(response.headers["Server"], "Flamingo \(Application.version)")
    XCTAssertEqual(response.headers["Content-Type"], "\(contentType.rawValue); charset=utf8")
    XCTAssertEqual(response.bodyString, "test")
  }

  func testBodyString() {
    let response = Response(status: .ok, body: "test")
    XCTAssertEqual(response.bodyString, "test")
  }
}
