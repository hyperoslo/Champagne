import XCTest
@testable import Flamingo

class KernelSchemeTests: XCTestCase {

  static var allTests: [(String, (KernelSchemeTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testDir", testDir)
    ]
  }

  var scheme: KernelScheme!

  override func setUp() {
    super.setUp()
    scheme = KernelScheme(name: "App")
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(scheme.name, "App")
  }

  func testDir() {
    XCTAssertEqual(scheme.dir.root, "App")
    XCTAssertEqual(scheme.dir.assets, "App/Assets")
    XCTAssertEqual(scheme.dir.web, "App/Web")
  }
}
