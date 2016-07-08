import XCTest
@testable import Champagne

class ResponseTests: XCTestCase {

  static var allTests: [(String, (ResponseTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testInitWithHeaders", testInitWithHeaders),
      ("testStatusLine", testStatusLine),
      ("testDidUpgrade", testDidUpgrade),
      ("testBodyString", testBodyString),
      ("testDescription", testDescription)
    ]
  }

  var response: Response!
  let status: Status = .ok
  let mime: MimeType = .text

  override func setUp() {
    super.setUp()

    response = Response(
      status: status,
      mime: mime,
      body: "test"
    )
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(response.status, status)
    XCTAssertEqual(response.headers["Content-Type"], "\(mime.rawValue); charset=utf8")
    XCTAssertEqual(response.bodyString, "test")
  }

  func testInitWithHeaders() {
    let contentType = "\(MimeType.json.rawValue); charset=utf8"

    response = Response(
      status: status,
      headers: ["Content-Type": contentType],
      body: "test"
    )

    XCTAssertEqual(response.status, status)
    XCTAssertEqual(response.headers["Content-Type"], contentType)
    XCTAssertEqual(response.bodyString, "test")
  }

  func testStatusCode() {
    XCTAssertEqual(response.status.statusCode, response.status.statusCode)
  }

  func testStatusLine() {
    let result = "HTTP/1.1 " + response.status.statusCode.description
      + " " + response.status.reasonPhrase + "\n"
    XCTAssertEqual(response.statusLine, result)
  }

  func testDidUpgrade() {
    XCTAssertNil(response.storage["response-connection-upgrade"])
    response.didUpgrade = { request, stream in }
    XCTAssertNotNil(response.storage["response-connection-upgrade"])
  }

  func testBodyString() {
    response = Response(status: .ok, body: "test")
    XCTAssertEqual(response.bodyString, "test")
  }

  func testDescription() {
    let result = response.statusLine + response.headers.description
    XCTAssertEqual(response.description, result)
  }
}
