import XCTest
@testable import Flamingo

class ResponseTests: XCTestCase {

  static var allTests: [(String, (ResponseTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testInitWithHeaders", testInitWithHeaders),
      ("testStatusCode", testStatusCode),
      ("testReasonPhrase", testReasonPhrase),
      ("testStatusLine", testStatusLine),
      ("testDidUpgrade", testDidUpgrade),
      ("testBodyString", testBodyString),
      ("testDescription", testDescription)
    ]
  }

  var response: Response!
  let status: Status = .ok
  let contentType: ContentType = .plain

  override func setUp() {
    super.setUp()

    response = Response(
      status: status,
      contentType: contentType,
      body: "test"
    )
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(response.status, status)
    XCTAssertEqual(response.headers["Server"], "Flamingo \(Application.version)")
    XCTAssertEqual(response.headers["Content-Type"], "\(contentType.rawValue); charset=utf8")
    XCTAssertEqual(response.bodyString, "test")
  }

  func testInitWithHeaders() {
    let contentType = "\(ContentType.json.rawValue); charset=utf8"
    response = Response(
      status: status,
      headers: ["Content-Type": contentType],
      body: "test"
    )

    XCTAssertEqual(response.status, status)
    XCTAssertEqual(response.headers["Server"], "Flamingo \(Application.version)")
    XCTAssertEqual(response.headers["Content-Type"], contentType)
    XCTAssertEqual(response.bodyString, "test")
  }

  func testStatusCode() {
    XCTAssertEqual(response.statusCode, response.status.statusCode)
  }

  func testReasonPhrase() {
    XCTAssertEqual(response.reasonPhrase, response.status.reasonPhrase)
  }

  func testStatusLine() {
    let result = "HTTP/1.1 " + response.statusCode.description
      + " " + response.reasonPhrase + "\n"
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
