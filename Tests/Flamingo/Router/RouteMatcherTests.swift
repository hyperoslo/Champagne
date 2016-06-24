import XCTest
@testable import Flamingo

class RouteMatcherTests: XCTestCase {

  static var allTests: [(String, (RouteMatcherTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(2, 2)
  }

  func testMatch() {
    var matcher = try! RouteMatcher(route: Route(path: "/home/test"))
    XCTAssertTrue(matcher.matches("/home/test"))
    XCTAssertFalse(matcher.matches("/home/test/index"))

    matcher = try! RouteMatcher(route: Route(path: "/api/:version"))
    XCTAssertTrue(matcher.matches("/api/v1"))
    XCTAssertFalse(matcher.matches("/api/v1/v1"))

    matcher = try! RouteMatcher(route: Route(path: "/birds/test"))
    XCTAssertTrue(matcher.matches("/birds/test"))
    XCTAssertFalse(matcher.matches("/birds/index"))

    matcher = try! RouteMatcher(route: Route(path: "/birds/:id/detail"))
    XCTAssertTrue(matcher.matches("/birds/1/detail"))
    XCTAssertFalse(matcher.matches("/birds/1/logs"))
  }
}
