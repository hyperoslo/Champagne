import XCTest
@testable import Flamingo

class KernelSchemeTests: XCTestCase {

  static var allTests: [(String, (KernelSchemeTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
