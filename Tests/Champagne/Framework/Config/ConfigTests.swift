import XCTest
@testable import Flamingo

class ConfigTests: XCTestCase {

  static var allTests: [(String, (ConfigTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testAbsolutize", testAbsolutize)
    ]
  }

  var config: Config!

  override func setUp() {
    super.setUp()
    config = Config(root: Globals.root)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(config.root, Globals.root)
    XCTAssertEqual(config.host, "0.0.0.0")
    XCTAssertEqual(config.port, 8080)
    XCTAssertEqual(config.environment, Environment("development"))
    XCTAssertTrue(config.server is WebServer.Type)
    XCTAssertTrue(config.bubbleSchemes.isEmpty)
    XCTAssertEqual(config.kernelScheme.name, "App")
    XCTAssertEqual(config.webDir, "\(Globals.root)/Web")
  }

  func testAbsolutize() {
    XCTAssertEqual(config.absolutize(path: "Test"), "\(Globals.root)/Test")
  }
}
