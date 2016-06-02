import XCTest
import PathKit
import String
#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif
@testable import Flamingo

class StencilRendererTests: XCTestCase {

  static var allTests: [(String, (StencilRendererTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testRenderWhenTemplateExists", testRenderWhenTemplateExists),
      ("testRenderWhenTemplateNotExist", testRenderWhenTemplateNotExist)
    ]
  }

  let context: [String: Any] = ["title": "Flamingo"]

  override func setUp() {
    super.setUp()
    Config.viewsDirectory = (Path(#file).parent().parent() + "Fixtures/Views").description
  }

  // MARK: - Tests

  func testInit() {
    let name = "index"
    let renderer = StencilRenderer(path: name, context: context)
    let path = Path(Config.viewsDirectory) + "\(name).html.stencil"

    XCTAssertEqual(renderer.path, path)
    XCTAssertEqual(renderer.context.count, 1)
    XCTAssertTrue(renderer.context["title"] as? String == "Flamingo")
  }

  func testRenderWhenTemplateExists() {
    let renderer = StencilRenderer(path: "index", context: context)
    let response = renderer.render()
    let html = "<!DOCTYPE html>\n<title>Flamingo</title>\n"

    XCTAssertEqual(response, html)
  }

  func testRenderWhenTemplateNotExist() {
    let renderer = StencilRenderer(path: "error", context: context)
    let response = renderer.render()
    let string = "Failed to render template"

    XCTAssertTrue(response.starts(with: string))
  }
}
