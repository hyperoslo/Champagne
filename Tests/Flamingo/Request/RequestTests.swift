import XCTest
@testable import Flamingo

class RequestTests: XCTestCase {

  static var allTests: [(String, (RequestTests) -> () throws -> Void)] {
    return [
      ("testPath", testPath),
      ("testQuery", testQuery),
      ("testParameters", testParameters),
      ("testPathParameters", testPathParameters),
      ("testConnection", testConnection),
      ("testIsKeepAliveWithoutConnection", testIsKeepAliveWithoutConnection),
      ("testIsKeepAliveWithCloseConnection", testIsKeepAliveWithCloseConnection),
      ("testIsKeepAliveWithKeepAliveConnection", testIsKeepAliveWithKeepAliveConnection),
      ("testBodyString", testBodyString)
    ]
  }

  var request: Request!

  override func setUp() {
    super.setUp()

    request = Request(
      method: Method.get,
      uri: URI(path: "/"),
      body: Data("")
    )
  }

  // MARK: - Tests

  func testPath() {
    XCTAssertEqual(request.path, request.uri.path)
  }

  func testQuery() {
    XCTAssertEqual(request.query.count, request.uri.query.count)
  }

  func testParameters() {
    request.parameters["foo"] = "bar"
    request.parameters["theme"] = "dark"

    XCTAssertEqual(request.parameters.count, 2)
    XCTAssertEqual(request.parameters["foo"], "bar")
    XCTAssertEqual(request.parameters["theme"], "dark")

    let storage = request.storage["fl-parameters"] as? [String: String]

    XCTAssertEqual(storage?.count, 2)
    XCTAssertEqual(storage?["foo"], "bar")
    XCTAssertEqual(storage?["theme"], "dark")
  }

  func testPathParameters() {
    request.pathParameters["foo"] = "bar"
    request.pathParameters["theme"] = "dark"

    XCTAssertEqual(request.pathParameters.count, 2)
    XCTAssertEqual(request.pathParameters["foo"], "bar")
    XCTAssertEqual(request.pathParameters["theme"], "dark")

    let storage = request.storage["path-parameters"] as? [String: String]

    XCTAssertEqual(storage?.count, 2)
    XCTAssertEqual(storage?["foo"], "bar")
    XCTAssertEqual(storage?["theme"], "dark")
  }

  func testConnection() {
    request.connection = "close"
    XCTAssertEqual(request.headers["connection"], "close")
  }

  func testIsKeepAliveWithoutConnection() {
    XCTAssertFalse(request.isKeepAlive)
  }

  func testIsKeepAliveWithCloseConnection() {
    request.connection = "close"
    request.version.minor = 1

    XCTAssertTrue(request.isKeepAlive)
  }

  func testIsKeepAliveWithKeepAliveConnection() {
    request.connection = "keep-alive"
    request.version.minor = 0

    XCTAssertTrue(request.isKeepAlive)
  }

  func testBodyString() {
    request.body = Body.buffer("test")
    XCTAssertEqual(request.bodyString, "test")
  }
}
