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
  }
}
