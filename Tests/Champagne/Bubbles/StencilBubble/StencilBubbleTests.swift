import XCTest
@testable import Champagne

class StencilBubbleTests: XCTestCase {

  static var allTests: [(String, (StencilBubbleTests) -> () throws -> Void)] {
    return [
      ("testScheme", testScheme),
      ("testMount", testMount)
    ]
  }

  let kernel = AppKernel()
  let container = Container()
  var bubble: Bubble!

  override func setUp() {
    super.setUp()

    container.register(Config.self) {
      return Config(root: Globals.root)
    }

    bubble = StencilBubble(container: container)
  }

  // MARK: - Tests

  func testScheme() {
    XCTAssertEqual(StencilBubble.scheme.name, "Stencil")
  }

  func testMount() {
    bubble.mount(on: kernel)
    XCTAssertTrue(container.resolve(TemplateEngine.self) is StencilEngine)
  }
}
