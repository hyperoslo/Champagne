import XCTest
import PathKit
@testable import Flamingo

class ApplicationControllerTests: XCTestCase {

  static var allTests: [(String, (ApplicationControllerTests) -> () throws -> Void)] {
    return [
      ("testRender", testRender)
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

    XCTAssertEqual(response.bodyString, html)
  }
}
