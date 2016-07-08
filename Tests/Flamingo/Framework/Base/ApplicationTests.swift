import XCTest
@testable import Flamingo

class ApplicationTests: XCTestCase {

  static var allTests: [(String, (ApplicationTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  var application: Application!

  // MARK: - Tests

  func testInit() {
    application = Globals.application

    XCTAssertEqual(application.middleware.count, 4)
    XCTAssertTrue(application.middleware[0] is QueryParametersMiddleware)
    XCTAssertTrue(application.middleware[1] is ErrorMiddleware)
  }
}
