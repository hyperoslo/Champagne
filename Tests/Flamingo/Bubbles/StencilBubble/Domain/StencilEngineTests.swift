import XCTest
import PathKit
import String
@testable import Flamingo

class StencilEngineTests: XCTestCase {

  static var allTests: [(String, (StencilRendererTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testRenderWhenTemplateExists", testRenderWhenTemplateExists)
    ]
  }

  let engine: StencilEngine!
  let context: [String: Any] = ["title": "Champagne"]

  override func setUp() {
    super.setUp()
    engine = StencilEngine(root: "/").description
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(engine.root, "/")
  }

  func testRenderWhenTemplateExists() {
    let response = engine.render(template: "index", context: context)
    let html = "<!DOCTYPE html>\n<title>Champagne</title>\n"

    XCTAssertEqual(response, html)
  }
}
