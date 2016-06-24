import XCTest
@testable import Flamingo

class RouteMatcherTests: XCTestCase {

  static var allTests: [(String, (RouteMatcherTests) -> () throws -> Void)] {
    return [
      ("testInitWithoutParameterKeys", testInitWithoutParameterKeys),
      ("testInitWitParameterKeys", testInitWitParameterKeys)
    ]
  }

  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests

  func testInitWithoutParameterKeys() {
    let matcher = RouteMatcher("/home/test")

    XCTAssertNotNil(matcher.regex)
    XCTAssertEqual(matcher.segments, [])
  }

  func testInitWitParameterKeys() {
    let matcher = RouteMatcher("/api/:version")

    XCTAssertNotNil(matcher.regex)
    XCTAssertEqual(matcher.segments, ["version"])
  }

  func testMatch() {
    var matcher = RouteMatcher("/home/test")
    XCTAssertTrue(matcher.matches("/home/test"))
    XCTAssertFalse(matcher.matches("/home/test/index"))

    matcher = RouteMatcher("/api/:version")
    XCTAssertTrue(matcher.matches("/api/v1"))
    XCTAssertFalse(matcher.matches("/api/v1/v1"))

    matcher = RouteMatcher("/birds/test")
    XCTAssertTrue(matcher.matches("/birds/test"))
    XCTAssertFalse(matcher.matches("/birds/index"))

    matcher = RouteMatcher("/birds/:id/detail")
    XCTAssertTrue(matcher.matches("/birds/1/detail"))
    XCTAssertFalse(matcher.matches("/birds/1/logs"))
  }

  func testParameters() {
    var matcher = RouteMatcher("/home/test")
    XCTAssertTrue(matcher.parameters("/home/test").isEmpty)

    matcher = RouteMatcher("/api/:version")
    XCTAssertEqual(matcher.parameters("/api/v1"), ["version": "v1"])
  }
}
