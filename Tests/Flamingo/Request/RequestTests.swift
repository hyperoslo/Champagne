import XCTest
@testable import Flamingo

class RequestTests: XCTestCase {

  static var allTests: [(String, (RequestTests) -> () throws -> Void)] {
    return [
      ("testParameters", testParameters),
      ("testBodyString", testBodyString)
    ]
  }

  var request: Request!

  override func setUp() {
    super.setUp()

    request = Request(
      method: Request.Method.get,
      uri: URI(path: "/"),
      body: Data("")
    )
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

  func testBodyString() {
    request.body = Body.buffer("test")
    XCTAssertEqual(request.bodyString, "test")
  }
}
