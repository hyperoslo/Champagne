import XCTest
@testable import Flamingo

class ApplicationTests: XCTestCase {

  static var allTests: [(String, (ApplicationTests) -> () throws -> Void)] {
    return [
      ("testMiddleware", testMiddleware),
      ("testInit", testMiddleware)
    ]
  }

  var application: Application!

  // MARK: - Tests

  func testMiddleware() {
    application = Application()

    XCTAssertEqual(application.middleware.count, 2)
    XCTAssertTrue(application.middleware[0] is ParametersMiddleware)
    XCTAssertTrue(application.middleware[1] is ErrorMiddleware)
  }

  func testInit() {
    let middleware: [Middleware] = [ErrorMiddleware()]
    application = Application(middleware: middleware)

    XCTAssertEqual(application.middleware.count, 3)
  }
}
