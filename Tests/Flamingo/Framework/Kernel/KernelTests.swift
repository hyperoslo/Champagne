import XCTest
@testable import Flamingo

class KernelTests: XCTestCase {

  static var allTests: [(String, (KernelTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
