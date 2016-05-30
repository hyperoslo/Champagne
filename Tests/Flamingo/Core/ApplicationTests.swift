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

  func testMiddleware() {
    application = Application()

    XCTAssertEqual(application.middleware.count, 3)
    XCTAssertTrue(application.middleware[0] is ParametersMiddleware)
    XCTAssertTrue(application.middleware[1] is CookiesMiddleware)
    XCTAssertTrue(application.middleware[2] is ErrorMiddleware)
  }

  func testInit() {
    let middleware: [Middleware] = [ErrorMiddleware()]
    application = Application(middleware: middleware)

    XCTAssertEqual(application.middleware.count, 4)
  }
}
