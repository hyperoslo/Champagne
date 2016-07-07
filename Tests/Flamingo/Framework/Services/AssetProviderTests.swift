import XCTest
@testable import Flamingo

class AssetProviderTests: XCTestCase {

  static var allTests: [(String, (AssetProviderTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }
}
