import XCTest
import PathKit
import String
@testable import Flamingo

class StencilEngineTests: XCTestCase {

  static var allTests: [(String, (StencilEngineTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testRenderWhenTemplateExists", testRenderWhenTemplateExists)
    ]
  }

  let context: [String: Any] = ["title": "Champagne"]
  let application = Globals.application
  var engine: StencilEngine!

  override func setUp() {
    super.setUp()
    engine = StencilEngine(root: application.config.root)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(engine.root, application.config.root)
  }

  func testRenderWhenTemplateExists() {
    do {
      let response = try engine.render(
        template: "Bubbles/AppBubble/Assets/Views/index",
        context: context
      )
      
      let html = "<!DOCTYPE html>\n<title>Champagne</title>\n"

      XCTAssertEqual(response, html)
    } catch {
      XCTFail("StencilEngine throws an error.")
    }
  }
}
