import XCTest
import PathKit
@testable import Flamingo

class ControllerTests: XCTestCase {

  static var allTests: [(String, (ControllerTests) -> () throws -> Void)] {
    return [
      ("testRenderTemplate", testRenderTemplate),
      ("testRender", testRender),
      ("testRenderJson", testRenderJson),
      ("testRenderData", testRenderData),
      ("testRespond", testRespond),
      ("testRedirect", testRedirect)
    ]
  }

  let resource = TestResource()

  override func setUp() {
    super.setUp()
    Config.viewsDirectory = (Path(#file).parent().parent() + "Fixtures/Views").description
  }

  // MARK: - Tests

  func testRenderTemplate() {
    let context: [String: Any] = ["title": "Flamingo"]
    let response = resource.render(template: "index", context: context)
    let html = "<!DOCTYPE html>\n<title>Flamingo</title>\n"

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, html)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.html.rawValue); charset=utf8"
    )
  }

  func testRender() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/index"),
      body: Data("")
    )

    let response = try? resource.index(request: request)
    let html = "<!DOCTYPE html>\n<title>Flamingo</title>\n"

    XCTAssertEqual(response?.status, Status.ok)
    XCTAssertEqual(response?.bodyString, html)
    XCTAssertEqual(
      response?.headers["Content-Type"],
      "\(MimeType.html.rawValue); charset=utf8"
    )
  }

  func testRenderJson() {
    let context = JSON.object(["title": "Flamingo", "count": 1])
    let response = resource.render(json: context)
    let string = "{\"count\":1,\"title\":\"Flamingo\"}"

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.json.rawValue); charset=utf8"
    )
  }

  func testRenderData() {
    let string = "string"
    let response = resource.render(data: string, mime: .text)

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.text.rawValue); charset=utf8"
    )
  }

  func testRespond() {
    var request = Request(
      method: Method.get,
      uri: URI(path: "/index"),
      body: Data("")
    )

    let context = JSON.object(["title": "Flamingo", "count": 1])
    let string = "{\"count\":1,\"title\":\"Flamingo\"}"

    request.headers["Accept"] = MimeType.json.rawValue

    let response = resource.respond(to: request, [
      .html: { self.resource.render(template: "index") },
      .json: { self.resource.render(json: context) }
    ])

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.json.rawValue); charset=utf8"
    )
  }

  func testRedirect() {
    let response = resource.redirect(to: "index")

    XCTAssertEqual(response.status, Status.found)
    XCTAssertEqual(response.headers["Location"], "index")
  }
}
