import XCTest
import PathKit
@testable import Flamingo

class ApplicationControllerTests: XCTestCase {

  static var allTests: [(String, (ApplicationControllerTests) -> () throws -> Void)] {
    return [
      ("testRender", testRender),
      ("testRenderJson", testRenderJson),
      ("testRenderData", testRenderData)
    ]
  }

  let controller = TestResourceController()

  override func setUp() {
    super.setUp()
    Config.viewsDirectory = (Path(#file).parent().parent() + "Fixtures/Views").description
  }

  // MARK: - Tests

  func testRender() {
    let context: [String: Any] = ["title": "Flamingo"]
    let response = controller.render("index", context: context)
    let html = "<!DOCTYPE html>\n<title>Flamingo</title>\n"

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, html)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.html.rawValue); charset=utf8"
    )
  }

  func testRenderJson() {
    let context = JSON.object(["title": "Flamingo", "count": 1])
    let response = controller.render(json: context)
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
    let response = controller.render(data: string, mime: .text)

    XCTAssertEqual(response.status, Status.ok)
    XCTAssertEqual(response.bodyString, string)
    XCTAssertEqual(
      response.headers["Content-Type"],
      "\(MimeType.text.rawValue); charset=utf8"
    )
  }
}
