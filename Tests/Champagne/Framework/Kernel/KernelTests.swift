import XCTest
@testable import Champagne

class KernelTests: XCTestCase {

  static var allTests: [(String, (KernelTests) -> () throws -> Void)] {
    return [
      ("testFrameworkBubbles", testFrameworkBubbles)
    ]
  }

  var kernel: Kernel!

  override func setUp() {
    super.setUp()
    kernel = AppKernel()
  }

  // MARK: - Tests

  func testFrameworkBubbles() {
    XCTAssertEqual(kernel.frameworkBubbles.count, 1)
    XCTAssertTrue(kernel.frameworkBubbles[0] == StencilBubble.self)
  }

  func testFrameworkMiddleware() {
    XCTAssertEqual(kernel.frameworkMiddleware.count, 4)
    XCTAssertTrue(kernel.frameworkMiddleware[0] is QueryParametersMiddleware)
    XCTAssertTrue(kernel.frameworkMiddleware[1] is BodyParametersMiddleware)
    XCTAssertTrue(kernel.frameworkMiddleware[2] is MethodMiddleware)
    XCTAssertTrue(kernel.frameworkMiddleware[3] is ErrorMiddleware)
  }

  func testService() {
    XCTAssertEqual(kernel.serviceMappers.count, 1)
    XCTAssertTrue(kernel.serviceMappers[0] is BootServiceMapper)
  }
}
