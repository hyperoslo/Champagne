import XCTest
@testable import Flamingo

class BubbleSchemeTests: XCTestCase {

  static var allTests: [(String, (BubbleSchemeTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testInitWithRoutePrefix", testInitWithRoutePrefix),
      ("testDir", testDir)
    ]
  }

  var scheme: BubbleScheme!

  override func setUp() {
    super.setUp()
    scheme = BubbleScheme(name: "Auth", routePrefix: "auth")
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(scheme.name, "Auth")
    XCTAssertEqual(scheme.routePrefix, "auth")
  }

  func testInitWithRoutePrefix() {
    scheme = BubbleScheme(name: "Auth")

    XCTAssertEqual(scheme.name, "Auth")
    XCTAssertEqual(scheme.routePrefix, "")

    scheme = BubbleScheme(name: "Auth", routePrefix: "Auth")

    XCTAssertEqual(scheme.name, "Auth")
    XCTAssertEqual(scheme.routePrefix, "auth")
  }

  func testDir() {
    scheme = BubbleScheme(name: "Auth")

    XCTAssertEqual(scheme.dir.root, "Bubbles/AuthBubble")
    XCTAssertEqual(scheme.dir.assets, "Bubbles/AuthBubble/Assets")
    XCTAssertEqual(scheme.dir.views, "Bubbles/AuthBubble/Assets/Views")
    XCTAssertEqual(scheme.dir.web, "Bubbles/AuthBubble/Web")
    XCTAssertEqual(scheme.dir.domain, "Bubbles/AuthBubble/Domain")
    XCTAssertEqual(scheme.dir.controllers, "Bubbles/AuthBubble/Domain/Controllers")
  }
}
