import XCTest
import PathKit
@testable import Flamingo

class ControllerTests: XCTestCase {

  let controller = TestResourceController()

  static var allTests: [(String, (ControllerTests) -> () throws -> Void)] {
    return [
      ("testRender", testRender),
    ]
  }

  override func setUp() {
    super.setUp()
    Config.viewsDirectory = (Path(#file).parent().parent() + "Fixtures/Views").description
  }

  func testRender() {
    let context: [String: Any] = ["title": "Flamingo"]
    let response = controller.render("index", context: context)
    let html = "<!DOCTYPE html>\n<title>Flamingo</title>\n"

    XCTAssertEqual(response.bodyString, html)
  }
}
