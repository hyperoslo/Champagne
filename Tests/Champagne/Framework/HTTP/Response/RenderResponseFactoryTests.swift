import XCTest
@testable import Champagne

class RenderResponseFactoryTests: XCTestCase {

  static var allTests: [(String, (RenderResponseFactoryTests) -> () throws -> Void)] {
    return [
      ("testRenderTemplate", testRenderTemplate),
      ("testRenderJson", testRenderJson),
      ("testRenderData", testRenderData),
      ("testRespond", testRespond),
      ("testRedirect", testRedirect)
    ]
  }

  var factory: RenderResponseFactory!
  let application = Globals.application

  var bubble: Bubble {
    return application.bubbles[1]
  }

  override func setUp() {
    super.setUp()
    factory = bubble.controller(ResourceController.self)
  }

  // MARK: - Tests

  func testRenderTemplate() {
    let context: [String: Any] = ["title": "Champagne"]
    let response = factory.render(template: "index", context: context)
    let html = "<!DOCTYPE html>\n<title>Champagne</title>\n"

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, html)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.html.rawValue); charset=utf8"
    )
  }

  func testRenderJson() {
    let context = JSON.object(["title": "Champagne", "count": 1])
    let response = factory.render(json: context)
    let string = "{\"count\":1,\"title\":\"Champagne\"}"

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.json.rawValue); charset=utf8"
    )
  }

  func testRenderData() {
    let string = "string"
    let response = factory.render(data: string, mime: .text)

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

    let context = JSON.object(["title": "Champagne", "count": 1])
    let string = "{\"count\":1,\"title\":\"Champagne\"}"

    request.headers["Accept"] = MimeType.json.rawValue

    let response = factory.respond(to: request, [
      .html: { self.factory.render(template: "index") },
      .json: { self.factory.render(json: context) }
    ])

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.json.rawValue); charset=utf8"
    )
  }

  func testRedirect() {
    let response = factory.redirect(to: "index")

    XCTAssertEqual(response.status, Status.found)
    XCTAssertEqual(response.headers["Location"], "index")
  }
}
