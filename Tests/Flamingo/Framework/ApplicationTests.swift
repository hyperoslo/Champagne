import XCTest
@testable import Flamingo

class ApplicationTests: XCTestCase {

  static var allTests: [(String, (ApplicationTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  var application: Application!

  override func setUp() {
    super.setUp()
    application = Globals.application
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(application.middleware.count, 4)
    XCTAssertTrue(application.middleware[0] is QueryParametersMiddleware)
    XCTAssertTrue(application.middleware[1] is BodyParametersMiddleware)
    XCTAssertTrue(application.middleware[2] is MethodMiddleware)
    XCTAssertTrue(application.middleware[3] is ErrorMiddleware)
  }
}
