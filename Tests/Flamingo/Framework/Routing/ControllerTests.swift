import XCTest
import PathKit
@testable import Flamingo

class ControllerTests: XCTestCase {

  static var allTests: [(String, (ControllerTests) -> () throws -> Void)] {
    return [
      ("testRender", testRender),
    ]
  }

  var resource: ResourceController!
  let application = Globals.application

  var bubble: Bubble {
    return application.bubbles[1]
  }

  override func setUp() {
    super.setUp()
    resource = bubble.controller(ResourceController.self)
  }

  // MARK: - Tests

  func testRender() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/index"),
      body: Data("")
    )

    let response = try? resource.index(request: request)
    let html = "<!DOCTYPE html>\n<title>Champagne</title>\n"

    XCTAssertEqual(response?.status, Status.ok)
    XCTAssertEqual(response?.bodyString, html)
    XCTAssertEqual(
      response?.headers["Content-Type"],
      "\(MimeType.html.rawValue); charset=utf8"
    )
  }
}
